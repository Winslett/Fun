require 'spec_helper'

describe "Banner" do
  def app
    TwilioMongoBootstrap
  end

  it "shows banner" do
    get "/"
    last_response.status.should eq(200)
  end

end

