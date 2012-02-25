require 'sinatra/base'
require 'sinatra/reloader'

class SinatraMongoBootstrap < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload "#{Dir.pwd}/models/*"
  end

end
