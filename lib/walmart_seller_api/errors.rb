# frozen_string_literal: true

module WalmartSellerApi
  class Error < StandardError; end

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

      klass =
        case status_code
        when 400
          ValidationError
        when 401
          AuthenticationError
        when 403
          AuthorizationError
        when 404
          NotFoundError
        when 429
          RateLimitError
        when 500..599
          ServerError
        else
          self
        end

      klass.new(error_message, status_code, response_body, response_headers)
    end

    class AuthenticationError < ApiError; end
    class AuthorizationError < ApiError; end
    class RateLimitError < ApiError; end
    class ValidationError < ApiError; end
    class NotFoundError < ApiError; end
    class ServerError < ApiError; end
    class NetworkError < ApiError; end

    def self.extract_error_message(response_body)
      return "Unknown error" if response_body.blank?

      begin
        parsed = JSON.parse(response_body)
        error_message = find_error_message(parsed) if parsed.is_a?(Hash)
        error_message || "Unknown error"
      rescue JSON::ParserError
        response_body
      end
    end

    private_class_method def self.find_error_message(data)
      message = nil

      [data.dig("errors", "error"), data["error"], data].each do |error|
        message = form_error_message(error)
        break if message.present?
      end

      message
    end

    private_class_method def self.form_error_message(error)
      message =
        if error.is_a?(Array)
          error.map { |e| error_message(e) }.compact.to_sentence
        else
          error_message(error)
        end

      message.presence
    end

    private_class_method def self.error_message(data)
      return data if data.is_a?(String)
      return unless data.is_a?(Hash)

      data["message"] || data["description"] || data["info"]
    end
  end
end
