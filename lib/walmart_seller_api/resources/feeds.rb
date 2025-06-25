# frozen_string_literal: true

module WalmartSellerApi
  module Resources
    class Feeds < Base
      # Submit a new feed
      def submit_feed(feed_type, file_path, params = {})
        path = "/v3/feeds"
        file = File.open(file_path, 'rb')
        query = {
          feedType: feed_type
        }
        body = {
          file: file
        }.merge(params)
        headers = {
          'Content-Type' => 'multipart/form-data'
        }
        post(path, query: query, body: body, headers: headers)
      ensure
        file.close if file
      end

      # Get feed status by feedId
      def get_feed_status(feed_id)
        path = "/v3/feeds/#{feed_id}"
        get(path)
      end

      # Get feed results by feedId
      def get_feed_result(feed_id)
        path = "/v3/feeds/#{feed_id}/result"
        get(path)
      end

      # List feeds with optional filters
      def list_feeds(feed_type: nil, status: nil, limit: 10, offset: 0)
        path = "/v3/feeds"
        params = build_query_params({
          feedType: feed_type,
          status: status,
          limit: limit,
          offset: offset
        })
        get(path, query: params)
      end
    end
  end
end
