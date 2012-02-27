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

  before_filter :log_params

  post "/signup" do
    puts @params
    @user = User.create("phone" => @params["from"], "name" => @params["body"])

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
end
