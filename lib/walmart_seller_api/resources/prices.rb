# frozen_string_literal: true

module WalmartSellerApi
  module Resources
    class Prices < Base
      # Updates the price of a single item identified by its SKU.
      #
      # @param sku [String] The SKU of the item whose price will be updated.
      # @param amount [Numeric] The new price to set for the item.
      #
      # @see https://developer.walmart.com/us-marketplace/reference/updateprice
      #   Walmart Marketplace Prices API: Update a price
      def update_price(sku, amount)
        body = build_request_body(
          sku: sku,
          pricing: [{
            currentPriceType: "BASE",
            currentPrice: {
              currency: "USD",
              amount: amount
            }
          }]
        )
        put("/v3/price", body: body)
      end
    end
  end
end
