require 'faraday'
require 'faraday_middleware'

module Airdye
  module IO
    class Client
      extend Memoist

      def host
        ENV['AIRDYE_IO_URL'] || 'https://airdye.io'
      end

      def username
        ENV['AIRDYE_IO_USERNAME']
      end

      def password
        ENV['AIRDYE_IO_PASSWORD']
      end

      def get(path, options = nil)
        response = connection.get(File.join('api', path), options)
        response.body
      end

      def post(path, payload = {})
        response = connection.post(File.join('api', path), payload)
        response.body
      end

      def connection
        uri = Addressable::URI.parse(host)
        conn = Faraday.new(uri.to_s) do |builder|
          if Rails.env.development?
            builder.response :logger
          end

          builder.adapter  :patron
          # encodes ruby Hashes/Arrays in POST bodies as "application/json"
          builder.request :json
          builder.response :json, :content_type => /\b(json|json-home)$/
          builder.response :mashify
        end

        conn.options.timeout = 20           # open/read timeout in seconds
        conn.options.open_timeout = 20      # connection open timeout in seconds
        # All requests are JSON
        conn.headers['Content-Type'] = 'application/json'
        conn.basic_auth(username, password)
        conn
      end
      memoize :connection

    end
  end
end