$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'fosdick'
require 'vcr'

if ENV['FOSDICK_USERNAME'].nil?
  raise "Set up your .env file and use `foreman run rake`!"
end


VCR.configure do |config|
  config.cassette_library_dir = "spec/cassettes"
  config.hook_into :faraday
  config.configure_rspec_metadata!
  config.allow_http_connections_when_no_cassette = false

  config.default_cassette_options = {
    record: :none
  }
end

RSpec.configure do |config|
  config.before do
    Fosdick.configure do |fosdick|
      fosdick.client_code = ENV['FOSDICK_CLIENT_CODE']
      fosdick.client_name = ENV['FOSDICK_CLIENT_NAME']
      fosdick.username = ENV['FOSDICK_USERNAME']
      fosdick.password = ENV['FOSDICK_PASSWORD']
    end
  end
end
