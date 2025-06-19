# frozen_string_literal: true

module WalmartSellerApi
  module Resources
    class Base
      attr_reader :client

      def initialize(client)
        @client = client
      end

      protected

      def get(path, options = {})
        client.get(path, options)
      end

      def post(path, options = {})
        client.post(path, options)
      end

      def put(path, options = {})
        client.put(path, options)
      end

      def delete(path, options = {})
        client.delete(path, options)
      end

      def patch(path, options = {})
        client.patch(path, options)
      end

      def build_query_params(params)
        params.compact
      end

      def build_request_body(data)
        return nil if data.blank?

        if data.is_a?(String)
          data
        else
          data.to_json
        end
      end

      def handle_pagination(response, &block)
        return response unless response.is_a?(Hash) && response["list"]

        items = response["list"]
        yield(items) if block_given?

        # Handle pagination if present
        if response["totalCount"] && response["limit"] && response["offset"]
          total_count = response["totalCount"]
          limit = response["limit"]
          offset = response["offset"]

          if offset + limit < total_count
            # There are more pages
            next_offset = offset + limit
            next_response = get_with_pagination(next_offset, limit)
            handle_pagination(next_response, &block)
          end
        end

        response
      end

      def get_with_pagination(offset, limit)
        # Override in subclasses to implement pagination
        raise NotImplementedError, "Pagination not implemented for this resource"
      end
    end
  end
end 