require 'bundler'

Bundler.setup
Bundler.require

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
  {"name" => Faker::Name.name, "phone" => "+1" + Faker::PhoneNumber.phone_number.gsub(/[^0-9]/, '')[0..9]}
end
