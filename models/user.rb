require 'openssl'

class User

  PHONE_REGEX = /[\d]{10}/

  class << self

    def create(attributes)
      errors = []

      errors << "Name must be in body of SMS" if attributes["name"].nil? || attributes["name"] == ""
      errors << "Incorrect Phone Format" unless attributes["phone"] =~ PHONE_REGEX

      if errors.empty?
        user = $db.collection("users").find_one({"phone" => attributes["phone"]}, :fields => ["_id"])

        if user.nil? # Create a user
          user_id = $db.collection("users").insert(attributes.merge("auth_key" => OpenSSL::Random.random_bytes(16).unpack("H*")[0]))
        else
          user_id = $db.collection("users").update({_id: user["_id"]}, attributes)
        end

        self.find(user_id)
      else
        {"errors" => errors}
      end
    end

    def find(id)
      self.collection.find_one("_id" => id)
    end

    def all
      $db.collection("users").find().to_a
    end

    def collection
      $db.collection("users")
    end
  end

end
