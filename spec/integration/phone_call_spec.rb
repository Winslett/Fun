require 'spec_helper'

describe "User calls phone tree" do
  def app
    TwilioMongoBootstrap
  end

  before do
    User.collection.remove()
  end

  it "offers to connect people if we know you" do
    caller = User.create(new_user_attributes)
    recipient = User.create(new_user_attributes)

    post "/voice", sms_attributes("From" => caller["phone"])

    last_response.status.should eq(200)
    last_response.body.should == <<-RESPONSE
<?xml version='1.0' encoding='utf-8' ?>
<Response>
  <Say>Thank you for calling my Twilio Mongo Bootstrap</Say>
  <Gather action='/connect_extension' method='POST'>
    <Say>To call another member of the tree, please select one of the following</Say>
    <Say>For #{recipient["name"]} dial #{recipient["extension"]}</Say>
  </Gather>
</Response>
RESPONSE
  end

  it "connects folks" do
    caller = User.create(new_user_attributes)
    recipient = User.create(new_user_attributes)

    post "/connect_extension", sms_attributes("From" => caller["phone"])

    last_response.status.should eq(200)
    last_response.body.should == <<-RESPONSE
<?xml version='1.0' encoding='utf-8' ?>
<Response>
  <Dial>#{recipient["phone"]}</Dial>
</Response>
RESPONSE
  end

  it "does not offer to connect you if we don't know you" do
    caller = new_user_attributes
    recipient = User.create(new_user_attributes)

    post "/voice", sms_attributes("From" => caller["phone"])

    last_response.status.should eq(422)
    last_response.body.should == <<-RESPONSE
<?xml version='1.0' encoding='utf-8' ?>
<Response>
  <Say>Thank you for calling my Twilio Mongo Bootstrap</Say>
  <Say>Regretfully, we don't know who you are.  Please text your name to (205) 683-2303 to sign up.</Say>
</Response>
RESPONSE
  end
end

