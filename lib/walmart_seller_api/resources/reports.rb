# frozen_string_literal: true

module WalmartSellerApi
  module Resources
    class Reports < Base
      def get_available_reports
        path = "/v3/reports"
        get(path)
      end

      def create_report(report_type, report_params = {})
        path = "/v3/reports"
        body = {
          reportType: report_type,
          reportParams: report_params
        }

        post(path, body: build_request_body(body))
      end

      def get_report_status(report_id)
        path = "/v3/reports/#{report_id}"
        get(path)
      end

      def download_report(report_id)
        path = "/v3/reports/#{report_id}/download"
        get(path)
      end

      def get_orders_report(start_date, end_date, limit = 10, offset = 0)
        path = "/v3/reports/orders"
        params = build_query_params({
          startDate: start_date,
          endDate: end_date,
          limit: limit,
          offset: offset
        })

        get(path, query: params)
      end

      def get_inventory_report(limit = 10, offset = 0)
        path = "/v3/reports/inventory"
        params = build_query_params({
          limit: limit,
          offset: offset
        })

        get(path, query: params)
      end

      def get_items_report(limit = 10, offset = 0)
        path = "/v3/reports/items"
        params = build_query_params({
          limit: limit,
          offset: offset
        })

        get(path, query: params)
      end

      def get_returns_report(start_date, end_date, limit = 10, offset = 0)
        path = "/v3/reports/returns"
        params = build_query_params({
          startDate: start_date,
          endDate: end_date,
          limit: limit,
          offset: offset
        })

        get(path, query: params)
      end

      def get_financial_report(start_date, end_date, limit = 10, offset = 0)
        path = "/v3/reports/financial"
        params = build_query_params({
          startDate: start_date,
          endDate: end_date,
          limit: limit,
          offset: offset
        })

        get(path, query: params)
      end

      def get_performance_report(start_date, end_date, limit = 10, offset = 0)
        path = "/v3/reports/performance"
        params = build_query_params({
          startDate: start_date,
          endDate: end_date,
          limit: limit,
          offset: offset
        })

        get(path, query: params)
      end

      def get_quality_report(limit = 10, offset = 0)
        path = "/v3/reports/quality"
        params = build_query_params({
          limit: limit,
          offset: offset
        })

        get(path, query: params)
      end

      def get_issues_report(limit = 10, offset = 0)
        path = "/v3/reports/issues"
        params = build_query_params({
          limit: limit,
          offset: offset
        })

        get(path, query: params)
      end

      def get_issues_report_by_severity(severity, limit = 10, offset = 0)
        path = "/v3/reports/issues"
        params = build_query_params({
          severity: severity,
          limit: limit,
          offset: offset
        })

        get(path, query: params)
      end

      def get_issues_report_by_status(status, limit = 10, offset = 0)
        path = "/v3/reports/issues"
        params = build_query_params({
          status: status,
          limit: limit,
          offset: offset
        })

        get(path, query: params)
      end
    end
  end
end 