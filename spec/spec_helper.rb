require 'bundler'

Bundler.setup
Bundler.require

RACK_ENV = "test"

require 'faker'
require 'logger'
require File.dirname(__FILE__) + '/../twilio_mongo_bootstrap'
require 'rack/test'

initializers_path = File.dirname(__FILE__) + "/../initializers"
Dir.new(initializers_path).each do |file|
  next unless file =~ /\.rb$/
  require File.join(initializers_path, file)
end

models_path = File.dirname(__FILE__) + "/../models"
Dir.new(models_path).each do |file|
  next unless file =~ /\.rb$/
  require File.join(models_path, file)
end

RSpec.configure do |conf|
  conf.include Rack::Test::Methods

  conf.before(:suite) do
    $db.collection_names.each do |collection|
      next if collection =~ /^system/
      $db.drop_collection(collection)
    end
  end
end

def new_user_attributes
  {"name" => Faker::Name.name, "phone" => Faker::PhoneNumber.phone_number.gsub(/[^0-9]/, '')[0..9]}
end

def sms_attributes(new_attributes = {})
  {
    "AccountSid"=>OpenSSL::Random.random_bytes(16).unpack("H*")[0],
    "Body"=>Faker::Lorem.words(10),
    "ToZip"=>"94949",
    "FromState"=>"AL",
    "ToCity"=>"NOVATO",
    "SmsSid"=>"SM8bc646c74e2acd02a1832ac729525f5f",
    "ToState"=>"CA",
    "To"=>"4155992671",
    "ToCountry"=>"US",
    "FromCountry"=>"US",
    "SmsMessageSid"=>"SM8bc646c74e2acd02a1832ac729525f5f",
    "ApiVersion"=>"2008-08-01",
    "FromCity"=>"CARBON HILL",
    "SmsStatus"=>"received",
    "From"=>"2059243472",
    "FromZip"=>"35573"
  }.merge(new_attributes)
end
