# frozen_string_literal: true

module WalmartSellerApi
  module Resources
    class Shipping < Base
      def get_shipping_templates(limit = 10, offset = 0)
        path = "/v3/shipping/templates"
        params = build_query_params({
          limit: limit,
          offset: offset
        })

        get(path, query: params)
      end

      def get_shipping_template(template_id)
        path = "/v3/shipping/templates/#{template_id}"
        get(path)
      end

      def create_shipping_template(template_data)
        path = "/v3/shipping/templates"
        post(path, body: build_request_body(template_data))
      end

      def update_shipping_template(template_id, template_data)
        path = "/v3/shipping/templates/#{template_id}"
        put(path, body: build_request_body(template_data))
      end

      def delete_shipping_template(template_id)
        path = "/v3/shipping/templates/#{template_id}"
        delete(path)
      end

      def get_shipping_methods
        path = "/v3/shipping/methods"
        get(path)
      end

      def get_shipping_method(method_id)
        path = "/v3/shipping/methods/#{method_id}"
        get(path)
      end

      def get_shipping_zones
        path = "/v3/shipping/zones"
        get(path)
      end

      def get_shipping_zone(zone_id)
        path = "/v3/shipping/zones/#{zone_id}"
        get(path)
      end

      def calculate_shipping_rate(shipping_request)
        path = "/v3/shipping/rates"
        post(path, body: build_request_body(shipping_request))
      end

      def get_shipping_labels(order_id)
        path = "/v3/orders/#{order_id}/shipping/labels"
        get(path)
      end

      def create_shipping_label(order_id, label_request)
        path = "/v3/orders/#{order_id}/shipping/labels"
        post(path, body: build_request_body(label_request))
      end

      def get_carrier_methods
        path = "/v3/shipping/carriers"
        get(path)
      end

      def get_carrier_method(carrier_id)
        path = "/v3/shipping/carriers/#{carrier_id}"
        get(path)
      end

      def validate_address(address_data)
        path = "/v3/shipping/address/validate"
        post(path, body: build_request_body(address_data))
      end

      def get_tracking_info(tracking_number, carrier_name)
        path = "/v3/shipping/tracking"
        params = build_query_params({
          trackingNumber: tracking_number,
          carrierName: carrier_name
        })

        get(path, query: params)
      end
    end
  end
end 