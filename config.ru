require 'bundler'

Bundler.require

require 'logger'

Dir.open("./initializers").each do |file|
  next if file =~ /^\./
  require "./initializers/#{file}"
end

require './sinatra_mongo_bootstrap'

Dir.open("./models").each do |file|
  next if file =~ /^\./
  require "./models/#{file}"
end

run TwilioMongoBootstrap
