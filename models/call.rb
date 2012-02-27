class Call
  class << self
    def create(attributes)
      sender = User.find_by_phone(attributes["From"])

      document = {
        "sender" => {
          "name" => sender["name"],
          "phone" => sender["phone"],
          "_id" => sender["_id"]
        },
        "created_at" => Time.now,
        "body" => attributes["Body"],
        "recipient" => {
          "name" => attributes["recipient"]["name"],
          "phone" => attributes["recipient"]["phone"],
          "_id" => attributes["recipient"]["_id"],
        }
      }

      id = self.collection.insert(document)

      self.find(id)
    end

    def find(id)
      self.collection.find_one("_id" => id)
    end

    def all
      self.collection.find().to_a
    end

    def collection
      $db.collection("calls")
    end
  end
end