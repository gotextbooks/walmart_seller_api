# frozen_string_literal: true

require "bundler/setup"
require "walmart_seller_api"
require "webmock/rspec"
require "vcr"
require "dotenv"

Dotenv.load(".env.test", ".env")

VCR.configure do |config|
  config.cassette_library_dir = "spec/fixtures/vcr_cassettes"
  config.hook_into :webmock
  config.configure_rspec_metadata!
  config.filter_sensitive_data("<CLIENT_ID>") { ENV["WALMART_CLIENT_ID"] }
  config.filter_sensitive_data("<CLIENT_SECRET>") { ENV["WALMART_CLIENT_SECRET"] }
  config.filter_sensitive_data("<ACCESS_TOKEN>") { |interaction|
    if interaction.response.body
      JSON.parse(interaction.response.body)["access_token"] rescue nil
    end
  }
end

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
  config.filter_run_when_matching :focus
  config.example_status_persistence_file_path = "spec/examples.txt"
  config.disable_monkey_patching!
  config.warnings = true

  if config.files_to_run.one?
    config.default_formatter = "doc"
  end

  config.profile_examples = 10
  config.order = :random
  Kernel.srand config.seed
end 