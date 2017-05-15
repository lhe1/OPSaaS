require 'rubygems'
require '../lib/autoscaling/awsclient'

module OPSaaS
  module AutoScaling
    class ThorClient < Thor
      option :client_id, required: true, desc: 'client id', type: :string, default: 'client_id'
      option :environment, required: true, desc: 'environment', type: :string, default: 'default'
      option :region, default: 'us-east-1'
      desc 'getAsgInstancePrivateIps', ''
      def getAsgInstancePrivateIps
        ::OPSaaS::AutoScaling::AwsClient.new(options).getAsgInstancePrivateIps
      end

      option :client_id, required: true, desc: 'client id', type: :string, default: 'client_id'
      option :environment, required: true, desc: 'environment', type: :string, default: 'default'
      option :region, default: 'us-east-1'
      option :cmds, required: true, desc: 'commands', type: :array, default: '[]'
      desc 'updateAsgInstancesWithCmds', ''
      def updateAsgInstancesWithCmds
        ::OPSaaS::AutoScaling::AwsClient.new(options).updateAsgInstancesWithCmds(options["cmds"])
      end
    end
  end
end
