module Orion
  module Error
    class OrionError < StandardError
    end

    class Missing < OrionError
      def initialize(key_name)
        super "no #{key_name} provided"
      end
    end

    class ApiFailure < OrionError
      def initialize(api_res)
        super "unexpected response #{api_res.code}: #{api_res.body}"
      end
    end
  end
end
