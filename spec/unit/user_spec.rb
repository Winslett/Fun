require 'spec_helper'

describe User do

  it "finds or creates users" do
    attributes = new_user_attributes
    user = User.create(attributes)

    user["phone"].should == attributes["phone"]
    user["name"].should == attributes["name"]
    user["auth_key"].should_not be_nil
  end

  it "returns errors on phone with invalid phone" do
    attributes = new_user_attributes
    user = User.create(attributes.merge("phone" => "8675309"))

    user["errors"].length == 1
  end

  it "returns errors on name with blank name" do
    attributes = new_user_attributes
    user = User.create(attributes.merge("name" => ""))

    user["errors"].length == 1
  end

  it "finds one user" do
    attributes = new_user_attributes
    user = User.create(new_user_attributes)

    User.find(user["_id"])["_id"].should == user["_id"]
  end

  it "finds all users" do
    1.upto(5) do
      User.create(new_user_attributes)
    end

    User.all.length.should == 7
  end

end
