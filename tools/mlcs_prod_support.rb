require 'mysql2'

module Mysql
  class Database
    attr_accessor :endpoint, :databas, :username, :password

    def initialize(endpoint, database, username, password)
       @endpoint = endpoint
       @database = database
       @username = username
       @password = password     
     end

    def setup_ssh_tunnel
      # %x(ps -ef | grep 'ssh' | grep 3306 | awk '{print $2}' |xargs sudo kill -9)
      jumphost = ''
      if @endpoint.match(/prod/)
        jumphost = 'virprod'
      elsif "#@endpoint".match(/stage/)
        jumphost = 'virstage'
      elsif "#@endpoint".match(/dev/)
        jumphost = 'virdev'
      end
      rs = %x(ssh -f -N -n -L 3306:#@endpoint:3306 #{jumphost}) if !jumphost.empty?
    end

    def query(sqlarr)
      begin
        client = Mysql2::Client.new(
          :host =>'127.0.0.1', 
          :database => "#@database",
          :username => "#@username",
          :password => "#@password",
          :port => 3306
        )
        if sqlarr.class.eqls('Array')
          sqlarr.each do |sql|
            rs = client.query(sql)
            puts "Execute: #{sql}"
            rs.each do |row|
              puts row
            end
          end
        end
      rescue Mysql2::Error => e
        puts e.errno
        puts e.error
      ensure
        client.close if client
      end
    end
  end
end

mlcs_prod_support = Mysql::Database.new(
  'mlcs-prod-vir-rds-read.mobile.medu.com',
  'mlrs_production',
  'support',
  'yn7!:zF.cTm/YAm4'
)
mlcs_prod_sqlarr = [
  'select * from registration where id=16029'
]
mlcs_prod_support.setup_ssh_tunnel
mlcs_prod_support.query(mlcs_prod_sqlarr)
