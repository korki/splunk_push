require 'bundler'
require 'rubygems'

Bundler.require(:default, :test)
require 'webmock/rspec'
require 'vcr'

require File.join(File.dirname(__FILE__), '..', 'lib', 'splunk_push.rb')

VCR.configure do |c|
  c.allow_http_connections_when_no_cassette = true
  c.cassette_library_dir = './spec/vcr_cassettes'
  c.hook_into :webmock
end

RSpec.configure do |config|
  config.mock_framework = :rspec
end
