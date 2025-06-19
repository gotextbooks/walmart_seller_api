# frozen_string_literal: true

module WalmartSellerApi
  class Configuration
    attr_accessor :client_id, :client_secret, :environment, :timeout, :open_timeout, :logger

    def initialize
      @environment = :sandbox
      @timeout = 30
      @open_timeout = 10
    end

    def production?
      environment == :production
    end

    def sandbox?
      environment == :sandbox
    end

    def base_url
      case environment
      when :production
        "https://marketplace.walmartapis.com"
      when :sandbox
        "https://marketplace.walmartapis.com"
      else
        raise ArgumentError, "Invalid environment: #{environment}. Must be :sandbox or :production"
      end
    end

    def auth_url
      case environment
      when :production
        "https://marketplace.walmartapis.com/v3/token"
      when :sandbox
        "https://marketplace.walmartapis.com/v3/token"
      else
        raise ArgumentError, "Invalid environment: #{environment}. Must be :sandbox or :production"
      end
    end

    def validate!
      raise ArgumentError, "client_id is required" if client_id.blank?
      raise ArgumentError, "client_secret is required" if client_secret.blank?
      raise ArgumentError, "Invalid environment: #{environment}" unless %i[sandbox production].include?(environment)
    end
  end
end 