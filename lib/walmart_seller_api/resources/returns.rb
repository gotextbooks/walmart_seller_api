# frozen_string_literal: true

module WalmartSellerApi
  module Resources
    class Returns < Base
      # Retrieves return orders.
      #
      # @param options [Hash] A hash of optional query parameters
      # @option options [String] :return_order_id The return order ID to filter by.
      # @option options [String] :customer_order_id The customer order ID to filter by.
      # @option options [String] :status The return status (e.g., "INITIATED", "DELIVERED", "COMPLETED").
      # @option options [Boolean] :replacement_info Replacement information filter.
      # @option options [String] :return_type The type of return (e.g., "PREORDER", "REPLACEMENT", "REFUND").
      # @option options [String] :return_creation_start_date Start date for return creation (ISO 8601 format).
      # @option options [String] :return_creation_end_date End date for return creation (ISO 8601 format).
      # @option options [String] :return_last_modified_start_date Start date for last modification (ISO 8601 format).
      # @option options [String] :return_last_modified_end_date End date for last modification (ISO 8601 format).
      # @option options [Integer] :limit Maximum number of results to return. Must not exceed 200.
      #
      # @return [Hash] Paginated return orders.
      #
      # @see https://developer.walmart.com/us-marketplace/reference/getreturns
      def get_returns(options = {})
        path = "/v3/returns"
        query = build_query_params(
          returnOrderId: options[:return_order_id],
          customerOrderId: options[:customer_order_id],
          status: options[:status],
          replacementInfo: options[:replacement_info],
          returnType: options[:return_type],
          returnCreationStartDate: options[:return_creation_start_date],
          returnCreationEndDate: options[:return_creation_end_date],
          returnLastModifiedStartDate: options[:return_last_modified_start_date],
          returnLastModifiedEndDate: options[:return_last_modified_end_date],
          limit: options[:limit]
        )
        get(path, query: query)
      end
    end
  end
end
