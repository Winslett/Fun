require 'spec_helper'

describe "Users signing up via SMS" do
  def app
    SinatraMongoBootstrap
  end

  it "during signup" do
    post "/signup", {:body => "Chris Winslett", :from => "+12059243472"}
    last_response.status.should eq(200)
    last_response.body.should == "{ok: 1}"
  end
end
