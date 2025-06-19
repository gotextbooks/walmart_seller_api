# frozen_string_literal: true

require "spec_helper"

RSpec.describe WalmartSellerApi do
  before do
    WalmartSellerApi.configure do |config|
      config.client_id = "test_client_id"
      config.client_secret = "test_client_secret"
      config.environment = :sandbox
    end
  end

  describe ".configure" do
    it "allows configuration" do
      expect(WalmartSellerApi.config.client_id).to eq("test_client_id")
      expect(WalmartSellerApi.config.client_secret).to eq("test_client_secret")
      expect(WalmartSellerApi.config.environment).to eq(:sandbox)
    end
  end

  describe ".client" do
    it "returns a client instance" do
      expect(WalmartSellerApi.client).to be_a(WalmartSellerApi::Client)
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
end 