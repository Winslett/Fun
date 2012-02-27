require 'spec_helper'

describe "List users" do
  def app
    TwilioMongoBootstrap
  end

  it "shows all users" do
    1.upto(5) do
      User.create(new_user_attributes)
    end

    get "/users"

    last_response.status.should eq(200)
  end

end

