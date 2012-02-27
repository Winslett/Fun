require 'sinatra/base'
require 'sinatra/reloader'
require 'json'

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
      status(200)
      haml :"signup_errors.xml"
    end
  end

  get "/" do
    haml :"index.html"
  end

  get "/users" do
    @users = User.all

    haml :"users.html"
  end

  post "/voice" do
    @caller = User.find_by_phone(@params["From"])

    if @caller.nil?
      status(200)
      haml :"voice_errors.xml"
    else
      @users = User.all.find_all { |u| u["_id"] != @caller["_id"] }
      haml :"voice.xml"
    end
  end

  post "/sms" do
    puts @params.inspect
    return {ok: 1}.to_json
  end

  post "/connect_extension" do
    @caller = User.find_by_phone(@params["From"])

    if @caller.nil?
      status(200)
      haml :"voice_errors.xml"
    else
      @user = User.find_by_extension(@params["Digits"])
      haml :"connect_extension.xml"
    end
  end
end
