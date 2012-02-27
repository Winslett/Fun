require 'spec_helper'

describe Call do

  before do
    User.collection.remove()
    Call.collection.remove()
  end

  it "creates messages" do
    sender = User.create(new_user_attributes)
    recipient = User.create(new_user_attributes)

    call = Call.create(sms_attributes.merge("recipient" => recipient, "From" => sender["phone"]))

    call["recipient"]["name"].should == recipient["name"]
  end

end
