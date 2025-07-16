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

      opts = {
        body: body,
        query: query
      }

      if basic_auth = options.delete(:basic_auth)
        opts[:basic_auth] = basic_auth
      else
        headers["WM_SEC.ACCESS_TOKEN"] = access_token
      end

      opts[:headers] = headers
      response = self.class.send(method, url, opts)

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
      @access_token ||= authenticate
    end

    def authenticate
      response = post("/v3/token", {
        basic_auth: {
          username: configuration.client_id,
          password: configuration.client_secret
        },
        headers: {
          "Content-Type" => "application/x-www-form-urlencoded"
        },
        body: {
          grant_type: "client_credentials"
        }
      })

      response["access_token"]
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
