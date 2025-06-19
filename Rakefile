# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

require "rubocop/rake_task"
RuboCop::RakeTask.new(:rubocop)

task default: %i[rubocop spec]

desc "Run all tests and checks"
task ci: %i[rubocop spec]

desc "Build the gem"
task build: :clean do
  sh "gem build walmart_seller_api.gemspec"
end

desc "Clean build artifacts"
task :clean do
  sh "rm -f walmart_seller_api-*.gem"
end

desc "Install the gem locally"
task install: :build do
  sh "gem install walmart_seller_api-*.gem"
end

desc "Uninstall the gem"
task :uninstall do
  sh "gem uninstall walmart_seller_api"
end 