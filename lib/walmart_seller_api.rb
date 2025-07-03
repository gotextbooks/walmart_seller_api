# frozen_string_literal: true

require "httparty"
require "json"
require "active_support"
require "active_support/core_ext"
require "dry-configurable"

require_relative "walmart_seller_api/version"
require_relative "walmart_seller_api/configuration"
require_relative "walmart_seller_api/client"
require_relative "walmart_seller_api/errors"
require_relative "walmart_seller_api/resources/base"
require_relative "walmart_seller_api/resources/inventory"
require_relative "walmart_seller_api/resources/orders"
require_relative "walmart_seller_api/resources/items"
require_relative "walmart_seller_api/resources/shipping"
require_relative "walmart_seller_api/resources/reports"
require_relative "walmart_seller_api/resources/feeds"
require_relative "walmart_seller_api/resources/prices"

module WalmartSellerApi
  class << self
    def configure
      yield config
    end

    def config
      @config ||= Configuration.new
    end

    def inventory
      @inventory ||= Resources::Inventory.new(client)
    end

    def orders
      @orders ||= Resources::Orders.new(client)
    end

    def items
      @items ||= Resources::Items.new(client)
    end

    def shipping
      @shipping ||= Resources::Shipping.new(client)
    end

    def reports
      @reports ||= Resources::Reports.new(client)
    end

    def feeds
      @feeds ||= Resources::Feeds.new(client)
    end

    def prices
      @prices ||= Resources::Prices.new(client)
    end

    def reset!
      instance_variables.each do |ivar|
        instance_variable_set(ivar, nil) unless ivar == :@config
      end
    end

    private

    def client
      @client ||= Client.new
    end
  end
end
