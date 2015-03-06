module Airdye
  module DB
    class Base < ActiveRecord::Base
      self.primary_key = :Id

      establish_connection({
        adapter: 'sqlserver',
        # mode: 'dblib',
        dataserver:  ENV['TRANSPRINT_DB_HOST'],   # Name from freetds.conf, host or instance 'localhost\SQLEXPRESS'
        # host: 'xx',         # Used if dataserver is blank.
        port: 1433,              # Used if host present. Default is 1433.
        database: ENV['TRANSPRINT_DB'],
        username: ENV['TRANSPRINT_DB_USERNAME'],
        password: ENV['TRANSPRINT_DB_PASSWORD'],
        timeout: 5000,
        azure: true
        # adapter: 'sqlserver',
        # mode:    'ODBC',
        # dsn:     'Driver={SQL Server};Server=xxx,1433;Uid=xxx@xxx;Pwd=xxx;
        # Database=xxx',
        # azure:   true
      })
    end
  end
end

# Airdye::IO