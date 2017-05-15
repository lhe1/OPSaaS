require 'net/ssh'
require 'log4r'

module OPSaaS
  module AutoScaling
    class Client
      def initialize(options)
        @region = options["region"]
        @environment = options["environment"]
        @clientId = options["client_id"]

        @log_file = "#{@clientId}.log"
        @log = Logger.new(@log_file.to_s)

        @private_ips = []
      end

      def getAsgName
      end

      def getAsgInstancePrivateIps
      end

      def updateAsgInstancesWithCmds(cmds)
      end

      def rs(ssh, cmds)
        cmds.each do |cmd|
          @log.debug "[SSH>] #{cmd}"
          ssh.exec!(cmd) do |_ch, stream, data|
            @log.debug "[SSH:#{stream}>] #{data}"
          end
        end
      end

      def putLog
        File.open(@log_file.to_s).each do |line|
          print line
        end
      end
    end
  end
end
