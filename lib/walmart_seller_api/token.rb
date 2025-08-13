# frozen_string_literal: true

module WalmartSellerApi
  class Token
    def initialize(data)
      @data = data
      @expires_at = Time.current + data["expires_in"] - expiration_offset_seconds
    end

    def expired?
      @expires_at.past?
    end

    def value
      @data["access_token"]
    end

    private

    def expiration_offset_seconds
      WalmartSellerApi.config.expiration_offset_seconds
    end
  end
end
