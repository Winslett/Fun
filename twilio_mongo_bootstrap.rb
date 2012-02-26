require 'sinatra/base'
require 'sinatra/reloader'

class TwilioMongoBootstrap < Sinatra::Base
  configure :development do
    register Sinatra::Reloader
    also_reload "#{Dir.pwd}/models/*"

    enable :logging
  end

  helpers do
    def base_url
      @base_url ||= "#{request.env['rack.url_scheme']}://#{request.env['HTTP_HOST']}"
    end
  end

  post "/signup" do
    @user = User.create("phone" => @params["from"], "name" => @params["body"])

    if @user["errors"].nil?
      haml :"signup.xml"
    else
      @errors = @user["errors"]
      status(422)
      haml :"signup_errors.xml"
    end
  end

end
