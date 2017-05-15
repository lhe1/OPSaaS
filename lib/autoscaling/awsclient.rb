require 'aws-sdk-core'

require_relative './client'

module OPSaaS
  module AutoScaling
    class AwsClient < Client
      def initialize(options)
        super
        @aws_profile = Aws::SharedCredentials.new(profile_name: @environment)
      end

      def getAsgName
        asg = Aws::AutoScaling::Client.new(region: @region, credentials: @aws_profile)

        begin
          resp = asg.describe_tags(
            filters: [
              {
                name: 'value',
                values: ['learn-' + @environment + '-' + @clientId]
              }
            ]
          )
        rescue Aws::AutoScaling::Errors::Throttling
          puts 'Throttled. Retrying...'
          sleep(30)
          retry
        end

        asg_count = resp.tags.count
        raise "ASG Count greater than expected for #{@clientId}: #{asg_count}" if asg_count > 1
        raise "No ASGs found for #{@clientId}" if asg_count == 0
        asgName = resp.tags.first.resource_id
      end

      def getAsgInstancePrivateIps
        asgName = getAsgName
        asg = Aws::AutoScaling::Client.new(region: @region, credentials: @aws_profile)

        resp = asg.describe_auto_scaling_groups(auto_scaling_group_names: [asgName.to_s])
        resp.auto_scaling_groups[0].instances.each do |instance|
          instance_id = instance.instance_id
          ec2 = Aws::EC2::Client.new(region: @region, credentials: @aws_profile)

          resp = ec2.describe_instances(instance_ids: [instance_id.to_s])
          private_ip = resp.reservations[0].instances[0].private_ip_address
          @private_ips << private_ip
        end

        @private_ips.each do |private_ip|
          puts private_ip
        end
      end

      def updateAsgInstancesWithCmds(cmds)
        asgName = getAsgName
        asg = Aws::AutoScaling::Client.new(region: @region, credentials: @aws_profile)
        
        # Suspend ASG.
        @log.debug "Suspend the ASG #{asgName}."
        asg.suspend_processes(auto_scaling_group_name: asgName.to_s)

        # Get the private ip list.
        getAsgInstancePrivateIps
        
        # Do something on each instance in the ASG.
        @private_ips.each do |private_ip|
          Net::SSH.start("#{@environment}+#{private_ip}") do |ssh|
            rs(ssh, cmds)
            ssh.loop
          end
        end

        # Resume ASG.
        @log.debug "Resume the ASG #{asgName}."
        asg.resume_processes(auto_scaling_group_name: asgName.to_s)

        # View logs
        putLog
      end
    end
  end
end
