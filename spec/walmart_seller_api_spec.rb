# frozen_string_literal: true

require "spec_helper"

RSpec.describe WalmartSellerApi do
  before do
    WalmartSellerApi.configure do |config|
      config.client_id = "test_client_id"
      config.client_secret = "test_client_secret"
      config.environment = :sandbox
    end

    stub_request(:post, %r{/v3/token}).to_return(
      status: 200,
      body: {
        'access_token' => 'access_token',
        'expires_in' => 900
      }.to_json
    )
  end

  describe ".configure" do
    it "allows configuration" do
      expect(WalmartSellerApi.config.client_id).to eq("test_client_id")
      expect(WalmartSellerApi.config.client_secret).to eq("test_client_secret")
      expect(WalmartSellerApi.config.environment).to eq(:sandbox)
    end
  end

  describe ".inventory" do
    it "returns an inventory resource" do
      expect(WalmartSellerApi.inventory).to be_a(WalmartSellerApi::Resources::Inventory)
    end
  end

  describe ".orders" do
    it "returns an orders resource" do
      expect(WalmartSellerApi.orders).to be_a(WalmartSellerApi::Resources::Orders)
    end
  end

  describe ".items" do
    it "returns an items resource" do
      expect(WalmartSellerApi.items).to be_a(WalmartSellerApi::Resources::Items)
    end
  end

  describe ".shipping" do
    it "returns a shipping resource" do
      expect(WalmartSellerApi.shipping).to be_a(WalmartSellerApi::Resources::Shipping)
    end
  end

  describe ".reports" do
    it "returns a reports resource" do
      expect(WalmartSellerApi.reports).to be_a(WalmartSellerApi::Resources::Reports)
    end
  end

  describe ".returns" do
    let(:returns) { described_class.returns }

    describe "#get_returns" do
      let!(:api_request) do
        stub_request(:get, %r{/v3/returns}).to_return(
          body: {
            'returnOrders' => []
          }.to_json
        )
      end

      it "sends request with no query parameters" do
        uri = nil
        api_request.with do |req|
          uri = req.uri
        end

        returns.get_returns

        expect(api_request).to have_been_made.once

        params = uri.query_values
        expect(params).to be_nil
      end

      it "sets the returnOrderId query parameter" do
        uri = nil
        api_request.with do |req|
          uri = req.uri
        end

        returns.get_returns(return_order_id: "value")

        expect(api_request).to have_been_made.once

        params = uri.query_values
        expect(params["returnOrderId"]).to eq("value")
      end

      it "sets the customerOrderId query parameter" do
        uri = nil
        api_request.with do |req|
          uri = req.uri
        end

        returns.get_returns(customer_order_id: "value")

        expect(api_request).to have_been_made.once

        params = uri.query_values
        expect(params["customerOrderId"]).to eq("value")
      end

      it "sets the status query parameter" do
        uri = nil
        api_request.with do |req|
          uri = req.uri
        end

        returns.get_returns(status: "value")

        expect(api_request).to have_been_made.once

        params = uri.query_values
        expect(params["status"]).to eq("value")
      end

      it "sets the replacementInfo query parameter" do
        uri = nil
        api_request.with do |req|
          uri = req.uri
        end

        returns.get_returns(replacement_info: "value")

        expect(api_request).to have_been_made.once

        params = uri.query_values
        expect(params["replacementInfo"]).to eq("value")
      end

      it "sets the returnType query parameter" do
        uri = nil
        api_request.with do |req|
          uri = req.uri
        end

        returns.get_returns(return_type: "value")

        expect(api_request).to have_been_made.once

        params = uri.query_values
        expect(params["returnType"]).to eq("value")
      end

      it "sets the returnCreationStartDate query parameter" do
        uri = nil
        api_request.with do |req|
          uri = req.uri
        end

        returns.get_returns(return_creation_start_date: "value")

        expect(api_request).to have_been_made.once

        params = uri.query_values
        expect(params["returnCreationStartDate"]).to eq("value")
      end

      it "sets the returnCreationEndDate query parameter" do
        uri = nil
        api_request.with do |req|
          uri = req.uri
        end

        returns.get_returns(return_creation_end_date: "value")

        expect(api_request).to have_been_made.once

        params = uri.query_values
        expect(params["returnCreationEndDate"]).to eq("value")
      end

      it "sets the returnLastModifiedStartDate query parameter" do
        uri = nil
        api_request.with do |req|
          uri = req.uri
        end

        returns.get_returns(return_last_modified_start_date: "value")

        expect(api_request).to have_been_made.once

        params = uri.query_values
        expect(params["returnLastModifiedStartDate"]).to eq("value")
      end

      it "sets the returnLastModifiedEndDate query parameter" do
        uri = nil
        api_request.with do |req|
          uri = req.uri
        end

        returns.get_returns(return_last_modified_end_date: "value")

        expect(api_request).to have_been_made.once

        params = uri.query_values
        expect(params["returnLastModifiedEndDate"]).to eq("value")
      end

      it "sets the limit query parameter" do
        uri = nil
        api_request.with do |req|
          uri = req.uri
        end

        returns.get_returns(limit: "value")

        expect(api_request).to have_been_made.once

        params = uri.query_values
        expect(params["limit"]).to eq("value")
      end
    end
  end
end
