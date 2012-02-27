require 'spec_helper'

describe "User sms's" do
  def app
    TwilioMongoBootstrap
  end

  before do
    User.collection.remove()
    Sms.collection.remove()
  end

  it "sends successfully" do
    sender = User.create(new_user_attributes)

    post "/sms", sms_attributes("From" => sender["phone"])

    last_response.status.should eq(200)

    last_response.body.should == "{\"ok\":1}"
  end


  it "responds with failure" do
    sender = new_user_attributes

    post "/sms", sms_attributes("From" => sender["phone"])

    last_response.status.should eq(200)

    last_response.body.should == <<-RESPONSE
<?xml version='1.0' encoding='utf-8' ?>
<Response>
  <Sms>Regretfully, we don't know who you are. Please text your name to (205) 683-2303 to sign up.</Sms>
</Response>
RESPONSE
  end

end

