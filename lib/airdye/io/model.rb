
module Airdye
  module IO
    class Model

      class << self
        extend Memoist

        def endpoint
          File.join('api', self.name.demodulize.downcase.pluralize)
        end

        def get(path)
          response = connection.get(File.join(endpoint, path))
          response.body
        end

        def connection
          uri = Addressable::URI.parse(ENV['AIRDYE_IO_URL'])
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
          conn.basic_auth(ENV['AIRDYE_IO_USERNAME'], ENV['AIRDYE_IO_PASSWORD'])
          conn
        end
        memoize :connection
      end

    end
  end
end

