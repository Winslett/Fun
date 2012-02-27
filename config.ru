RACK_ENV = ENV["RACK_ENV"] || "development"

require 'bundler'

Bundler.require

require 'logger'

$stdout.sync = true

Dir.open("./initializers").each do |file|
  next if file =~ /^\./
  require "./initializers/#{file}"
end

require './twilio_mongo_bootstrap'

Dir.open("./models").each do |file|
  next if file =~ /^\./
  require "./models/#{file}"
end

run TwilioMongoBootstrap
