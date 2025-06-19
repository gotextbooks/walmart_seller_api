# frozen_string_literal: true

module WalmartSellerApi
  class Error < StandardError; end

  class AuthenticationError < Error; end
  class AuthorizationError < Error; end
  class RateLimitError < Error; end
  class ValidationError < Error; end
  class NotFoundError < Error; end
  class ServerError < Error; end
  class NetworkError < Error; end

  class ApiError < Error
    attr_reader :status_code, :response_body, :response_headers

    def initialize(message, status_code = nil, response_body = nil, response_headers = nil)
      super(message)
      @status_code = status_code
      @response_body = response_body
      @response_headers = response_headers
    end

    def self.from_response(response)
      status_code = response.code
      response_body = response.body
      response_headers = response.headers

      error_message = extract_error_message(response_body)

      case status_code
      when 400
        ValidationError.new(error_message, status_code, response_body, response_headers)
      when 401
        AuthenticationError.new(error_message, status_code, response_body, response_headers)
      when 403
        AuthorizationError.new(error_message, status_code, response_body, response_headers)
      when 404
        NotFoundError.new(error_message, status_code, response_body, response_headers)
      when 429
        RateLimitError.new(error_message, status_code, response_body, response_headers)
      when 500..599
        ServerError.new(error_message, status_code, response_body, response_headers)
      else
        ApiError.new(error_message, status_code, response_body, response_headers)
      end
    end

    private

    def self.extract_error_message(response_body)
      return "Unknown error" if response_body.blank?

      begin
        parsed = JSON.parse(response_body)
        if parsed.is_a?(Hash)
          parsed["error"] || parsed["message"] || parsed["description"] || "Unknown error"
        else
          "Unknown error"
        end
      rescue JSON::ParserError
        response_body
      end
    end
  end
end 