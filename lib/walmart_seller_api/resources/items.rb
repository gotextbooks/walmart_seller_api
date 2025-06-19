# frozen_string_literal: true

module WalmartSellerApi
  module Resources
    class Items < Base
      def get_items(limit = 10, offset = 0, lifecycle_status = nil)
        path = "/v3/items"
        params = build_query_params({
          limit: limit,
          offset: offset,
          lifecycleStatus: lifecycle_status
        })

        get(path, query: params)
      end

      def get_item(sku)
        path = "/v3/items/#{sku}"
        get(path)
      end

      def create_item(item_data)
        path = "/v3/items"
        post(path, body: build_request_body(item_data))
      end

      def update_item(sku, item_data)
        path = "/v3/items/#{sku}"
        put(path, body: build_request_body(item_data))
      end

      def delete_item(sku)
        path = "/v3/items/#{sku}"
        delete(path)
      end

      def retire_item(sku)
        path = "/v3/items/#{sku}/retire"
        post(path)
      end

      def get_item_by_mpn(mpn)
        path = "/v3/items"
        params = build_query_params({
          mpn: mpn
        })

        get(path, query: params)
      end

      def get_item_by_upc(upc)
        path = "/v3/items"
        params = build_query_params({
          upc: upc
        })

        get(path, query: params)
      end

      def get_items_by_status(status, limit = 10, offset = 0)
        get_items(limit, offset, status)
      end

      def bulk_create_items(items_data)
        path = "/v3/items/bulk"
        post(path, body: build_request_body(items_data))
      end

      def get_item_associations(sku)
        path = "/v3/items/#{sku}/associations"
        get(path)
      end

      def create_item_association(sku, association_data)
        path = "/v3/items/#{sku}/associations"
        post(path, body: build_request_body(association_data))
      end

      def delete_item_association(sku, association_id)
        path = "/v3/items/#{sku}/associations/#{association_id}"
        delete(path)
      end

      def get_item_issues(sku)
        path = "/v3/items/#{sku}/issues"
        get(path)
      end

      def get_item_issues_by_status(status, limit = 10, offset = 0)
        path = "/v3/items/issues"
        params = build_query_params({
          limit: limit,
          offset: offset,
          status: status
        })

        get(path, query: params)
      end

      def get_item_issues_by_severity(severity, limit = 10, offset = 0)
        path = "/v3/items/issues"
        params = build_query_params({
          limit: limit,
          offset: offset,
          severity: severity
        })

        get(path, query: params)
      end
    end
  end
end 