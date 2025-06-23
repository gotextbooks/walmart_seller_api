# frozen_string_literal: true

module WalmartSellerApi
  class Configuration
    include Dry::Configurable

    # OAuth 2.0
    setting :client_id
    setting :client_secret

    # HTTP client
    setting :environment, default: :sandbox
    setting :timeout, default: 30
    setting :open_timeout, default: 10
    setting :logger

    # Cache
    setting :token_expiry_buffer_seconds, default: 100
    setting :cache, default: ActiveSupport::Cache::MemoryStore.new

    delegate_missing_to :config

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
        "https://sandbox.walmartapis.com"
      else
        raise ArgumentError, "Invalid environment: #{environment}. Must be :sandbox or :production"
      end
    end

    def auth_url
      case environment
      when :production
        "https://marketplace.walmartapis.com/v3/token"
      when :sandbox
        "https://sandbox.walmartapis.com/v3/token"
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
