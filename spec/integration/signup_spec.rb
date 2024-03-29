require 'spec_helper'

describe "Users signing up via SMS" do
  def app
    TwilioMongoBootstrap
  end

  it "signs up" do
    attributes = new_user_attributes
    post "/signup", sms_attributes("Body" => attributes["name"], "From" => attributes["phone"])

    user = User.collection.find_one({phone: attributes["phone"]})

    last_response.status.should eq(200)
    last_response.body.should == <<-RESPONSE
<?xml version='1.0' encoding='utf-8' ?>
<Response>
  <Sms>Thank you for logging in.  Your phone tree phone number is 205-683-2295.  You can send SMS messages or call it.</Sms>
</Response>
RESPONSE
  end

  it "fails if data is incorrect" do
    attributes = {"name" => "", "from" => "8675309"}
    post "/signup", sms_attributes("Body" => attributes["name"], "From" => attributes["phone"])

    user = User.collection.find_one({phone: attributes["phone"]})

    last_response.status.should eq(200)

    user.should be_nil

    last_response.body.should =~ /Name must be in body of SMS/
    last_response.body.should =~ /Incorrect Phone Format/
  end
end

