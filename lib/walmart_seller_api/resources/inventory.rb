# frozen_string_literal: true

module WalmartSellerApi
  module Resources
    class Inventory < Base
      # Updates the inventory quantity for a given SKU.
      #
      # @param sku [String] The SKU of the item to update.
      # @param quantity [Integer] The quantity to set for the SKU.
      #
      # @see https://developer.walmart.com/us-marketplace/reference/updateinventoryforanitem-1
      #   Walmart Marketplace Inventory API: Update inventory for an item
      def update_inventory(sku, quantity)
        query = build_query_params(
          sku: sku
        )
        body = build_request_body(
          sku: sku,
          quantity: {
            unit: 'EACH',
            amount: quantity
          }
        )
        put('/v3/inventory', query: query, body: body)
      end
    end
  end
end
