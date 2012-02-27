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
    @user = User.create("phone" => @params["From"], "name" => @params["Body"])

    if @user["errors"].nil?
      haml :"signup.xml"
    else
      @errors = @user["errors"]
      status(422)
      haml :"signup_errors.xml"
    end
  end

  get "/" do
    @users = User.all

    haml :"users.html"
  end

  get "/voice" do
    puts @params.inspect
    return {ok: 1}.to_json
  end
end
