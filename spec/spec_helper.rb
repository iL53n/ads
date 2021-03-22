require 'rack/test'

ENV['RACK_ENV'] ||= 'test'
require_relative '../config/environment'

require_all 'spec/support'

RSpec.configure do |config|
  config.include Rack::Test::Methods
  config.include RequestHelpers, type: :request

  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
