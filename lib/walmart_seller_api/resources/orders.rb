# frozen_string_literal: true

module WalmartSellerApi
  module Resources
    class Orders < Base
      def get_orders(limit: 10, next_cursor: nil, status: nil, created_start_date: nil, created_end_date: nil)
        path = "/v3/orders"
        params = build_query_params({
          limit: limit,
          nextCursor: next_cursor,
          status: status,
          createdStartDate: created_start_date,
          createdEndDate: created_end_date
        })

        get(path, query: params)
      end

      def get_order(order_id)
        path = "/v3/orders/#{order_id}"
        get(path)
      end

      def acknowledge_order(order_id)
        path = "/v3/orders/#{order_id}/acknowledge"
        post(path)
      end

      def cancel_order(order_id, reason)
        path = "/v3/orders/#{order_id}/cancel"
        body = {
          orderLines: [
            {
              orderLineNumber: "1",
              orderLineStatuses: [
                {
                  status: "Cancelled",
                  cancellationReason: reason,
                  statusQuantity: {
                    amount: 1,
                    unit: "EACH"
                  }
                }
              ]
            }
          ]
        }

        post(path, body: build_request_body(body))
      end

      def ship_order(order_id, order_lines)
        path = "/v3/orders/#{order_id}/shipping"
        body = {
          orderLines: order_lines.map do |line|
            {
              orderLineNumber: line[:order_line_number],
              orderLineStatuses: [
                {
                  status: "Shipped",
                  statusQuantity: {
                    amount: line[:quantity],
                    unit: "EACH"
                  },
                  trackingInfo: {
                    shipDateTime: line[:ship_date_time],
                    carrierName: line[:carrier_name],
                    methodCode: line[:method_code],
                    carrierShipmentId: line[:tracking_number]
                  }
                }
              ]
            }
          end
        }

        post(path, body: build_request_body(body))
      end

      def refund_order(order_id, refund_lines)
        path = "/v3/orders/#{order_id}/refund"
        body = {
          orderLines: refund_lines.map do |line|
            {
              orderLineNumber: line[:order_line_number],
              orderLineStatuses: [
                {
                  status: "Refunded",
                  statusQuantity: {
                    amount: line[:quantity],
                    unit: "EACH"
                  },
                  refund: {
                    refundComments: line[:refund_comments],
                    refundCharges: line[:refund_charges]
                  }
                }
              ]
            }
          end
        }

        post(path, body: build_request_body(body))
      end

      def get_order_by_purchase_order_id(purchase_order_id)
        path = "/v3/orders/released"
        params = build_query_params({
          purchaseOrderId: purchase_order_id
        })

        get(path, query: params)
      end

      def get_orders_by_status(status, limit = 10, offset = 0)
        get_orders(limit, offset, status)
      end

      def get_orders_by_date_range(start_date, end_date, limit = 10, offset = 0)
        get_orders(limit, offset, nil, start_date, end_date)
      end
    end
  end
end
