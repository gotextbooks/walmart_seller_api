# frozen_string_literal: true

module WalmartSellerApi
  class Client
    include HTTParty

    attr_reader :configuration

    def initialize(configuration = nil)
      @configuration = configuration || WalmartSellerApi.config
      @configuration.validate!
      setup_http_client
    end

    def get(path, options = {})
      make_request(:get, path, options)
    end

    def post(path, options = {})
      make_request(:post, path, options)
    end

    def put(path, options = {})
      make_request(:put, path, options)
    end

    def delete(path, options = {})
      make_request(:delete, path, options)
    end

    def patch(path, options = {})
      make_request(:patch, path, options)
    end

    private

    def setup_http_client
      self.class.base_uri configuration.base_url
      self.class.default_timeout configuration.timeout
      self.class.open_timeout configuration.open_timeout
      self.class.headers default_headers
    end

    def default_headers
      {
        "Content-Type" => "application/json",
        "Accept" => "application/json",
        "WM_SEC.ACCESS_TOKEN" => access_token,
        "WM_QOS.CORRELATION_ID" => correlation_id,
        "WM_SVC.NAME" => "Walmart Marketplace"
      }
    end

    def make_request(method, path, options = {})
      url = build_url(path)
      headers = default_headers.merge(options[:headers] || {})
      body = options[:body]
      query = options[:query]

      log_request(method, url, headers, body, query)

      response = self.class.send(method, url, {
        headers: headers,
        body: body,
        query: query
      })

      log_response(response)
      handle_response(response)
    rescue HTTParty::Error => e
      raise NetworkError, "Network error: #{e.message}"
    end

    def build_url(path)
      path.start_with?("http") ? path : "#{configuration.base_url}#{path}"
    end

    def handle_response(response)
      case response.code
      when 200..299
        parse_response(response)
      else
        raise ApiError.from_response(response)
      end
    end

    def parse_response(response)
      return nil if response.body.blank?

      begin
        JSON.parse(response.body)
      rescue JSON::ParserError
        response.body
      end
    end

    def access_token
      configuration.cache.fetch(cache_key) do |_key, options|
        response = authenticate
        token_expiry_buffer_seconds = configuration.token_expiry_buffer_seconds
        options.expires_in = response["expires_in"] - token_expiry_buffer_seconds

        response["access_token"]
      end
    end

    def cache_key
      "walmart_seller_api:access_token:#{configuration.client_id}"
    end

    def authenticate
      auth_response = self.class.post(configuration.auth_url, {
        basic_auth: {
          username: configuration.client_id,
          password: configuration.client_secret
        },
        headers: {
          "Content-Type" => "application/x-www-form-urlencoded",
          "Accept" => "application/json",
          "WM_QOS.CORRELATION_ID" => correlation_id,
          "WM_SVC.NAME" => "Walmart Marketplace"
        },
        body: {
          grant_type: "client_credentials"
        }
      })

      if auth_response.success?
        JSON.parse(auth_response.body)
      else
        raise AuthenticationError, "Failed to authenticate: #{auth_response.body}"
      end
    rescue JSON::ParserError
      raise AuthenticationError, "Invalid authentication response"
    end

    def correlation_id
      SecureRandom.uuid
    end

    def log_request(method, url, headers, body, query)
      return unless configuration.logger

      configuration.logger.info "Walmart API Request: #{method.upcase} #{url}"
      configuration.logger.debug "Headers: #{headers.except('WM_SEC.ACCESS_TOKEN')}"
      configuration.logger.debug "Body: #{body}" if body
      configuration.logger.debug "Query: #{query}" if query
    end

    def log_response(response)
      return unless configuration.logger

      configuration.logger.info "Walmart API Response: #{response.code}"
      configuration.logger.debug "Response Body: #{response.body}" if response.body
    end
  end
end
