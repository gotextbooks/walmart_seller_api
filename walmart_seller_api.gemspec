# frozen_string_literal: true

require_relative "lib/walmart_seller_api/version"

Gem::Specification.new do |spec|
  spec.name = "walmart_seller_api"
  spec.version = WalmartSellerApi::VERSION
  spec.authors = ["Your Name"]
  spec.email = ["your.email@example.com"]

  spec.summary = "A Ruby SDK for Walmart Seller API"
  spec.description = "A comprehensive Ruby SDK for interacting with Walmart's Seller API, providing easy access to inventory management, order processing, and marketplace operations."
  spec.homepage = "https://github.com/yourusername/walmart_seller_api"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 2.7.0"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/blob/main/CHANGELOG.md"
  spec.metadata["rubygems_mfa_required"] = "true"

  spec.files = Dir.glob("{lib,spec}/**/*") + %w[README.md LICENSE.txt CHANGELOG.md]
  spec.require_paths = ["lib"]

  spec.add_dependency "httparty", "~> 0.21"
  spec.add_dependency "json", "~> 2.6"
  spec.add_dependency "activesupport", ">= 6.0"
  spec.add_dependency "dry-configurable", "~> 1.0"

  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.12"
  spec.add_development_dependency "webmock", "~> 3.18"
  spec.add_development_dependency "vcr", "~> 6.1"
  spec.add_development_dependency "rubocop", "~> 1.50"
  spec.add_development_dependency "rubocop-rspec", "~> 2.20"
  spec.add_development_dependency "simplecov", "~> 0.22"
  spec.add_development_dependency "pry", "~> 0.14"
  spec.add_development_dependency "dotenv", "~> 2.8"
end 