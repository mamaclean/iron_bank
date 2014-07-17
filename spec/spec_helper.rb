require 'minitest/autorun'
require 'vcr'
require 'turn'
require 'dotenv'

require_relative '../lib/iron_bank'

Dotenv.load

VCR.configure do |c|
  c.cassette_library_dir = 'spec/fixtures/iron_bank_cassettes'
  c.hook_into :webmock
end

MiniTest::Spec.class_eval do
  after(:suite) do
    system("bundle exec rake anonymize_auth_token")
  end
end
