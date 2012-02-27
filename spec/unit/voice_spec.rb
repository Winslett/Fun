require 'spec_helper'

describe Sms do

  before do
    User.collection.remove()
    Sms.collection.remove()
  end

  it "creates messages" do
    sender = User.create(new_user_attributes)

    1.upto(5) do
      User.create(new_user_attributes)
    end

    sms = Sms.create(sms_attributes("From" => sender["phone"]))
    sms["recipients"].length.should == 5
  end

end
