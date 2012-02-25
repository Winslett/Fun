require File.dirname(__FILE__) + '/../sinatra_mongo_bootstrap'
require 'rack/test'

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
end
