require 'net/ssh'

=begin
hostArr = [
  'virprod+ip-10-210-1-215.ec2.internal',
  'virprod+ip-10-210-8-235.ec2.internal',
  'virprod+ip-10-210-1-231.ec2.internal',
  'virprod+ip-10-210-8-184.ec2.internal',
  'fraprod+ip-10-211-1-6.eu-central-1.compute.internal',
  'fraprod+ip-10-211-8-63.eu-central-1.compute.internal',
  'sinprod+ip-10-212-1-144.ap-southeast-1.compute.internal',
  'sinprod+ip-10-212-9-166.ap-southeast-1.compute.internal',
  'sydprod+ip-10-213-9-137.ap-southeast-2.compute.internal',
  'sydprod+ip-10-213-0-50.ap-southeast-2.compute.internal'
]
=end

hostArr = [
  'virprod+ip-10-210-1-215.ec2.internal',
  'virprod+ip-10-210-8-235.ec2.internal',
  'virprod+ip-10-210-1-231.ec2.internal',
  'virprod+ip-10-210-8-184.ec2.internal'
]

=begin
hostArr = [
  'virprod+ip-10-210-1-215.ec2.internal',
  'virprod+ip-10-210-8-235.ec2.internal'
]
=end

kill_proc = %q{sudo ps -ef | grep logstash | grep java | awk '{print $2}' |xargs sudo kill -9}
check_proc = %q!sudo ps -ef | grep logstash | grep java!
run_chef_client = %Q(sudo chef-client)

threadArr = []
i = 0
hostArr.each do |host|
  puts host
  threadArr[i] = Thread.new do
    ssh = Net::SSH.start(host) do |ssh|
      result = ssh.exec!(check_proc)
      puts 'Initial state:'
      puts result

      result = ssh.exec!(kill_proc)

      result = ssh.exec!(check_proc)
      puts 'Temporary state:'
      puts result

      result = ssh.exec!(run_chef_client)

      result = ssh.exec!(check_proc)
      puts 'Final state:'
      puts result
    end
  end
  i += 1
end

threadArr.each do |thread|
  thread.join
end
