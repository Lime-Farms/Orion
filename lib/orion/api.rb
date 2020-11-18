require "json"
require "net/http"
require "uri"

module Orion
  module Api
    ENDPOINT = "https://api.vultr.com/v1".freeze

    def self.url(*args)
      URI.parse File.join(ENDPOINT, *args)
    end

    def self.useragent
      "#{NAME}/#{VERSION}".freeze
    end

    def self.get(url: nil, key: nil, decode: true)
      if url.nil?
        raise Error::Missing, "url"
      elsif key.nil?
        raise Error::Missing, "api key"
      end

      req = Net::HTTP::Get.new url
      req["Api-Key"] = key
      req["User-Agent"] = useragent

      res = Net::HTTP.start url.hostname, url.port, use_ssl: true do |http|
        http.request req
      end

      unless res.code.to_i == 200
        raise Error::ApiFailure, res
      else
        if decode
          JSON.parse res.body, symbolize_names: true
        else
          res.body
        end
      end
    end
  end
end
