class Sms
  class << self
    def create(attributes)
      sender = User.find_by_phone(attributes["From"])

      recipients = User.all().find_all { |u| u["_id"] != sender["_id"] }
      recipients = recipients.map { |u| {"name" => u["name"], "phone" => u["phone"], "_id" => u["_id"]} }

      document = {
        "sender" => {
          "name" => sender["name"],
          "phone" => sender["phone"],
          "_id" => sender["_id"]
        },
        "body" => attributes["Body"],
        "recipients" => recipients
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
      $db.collection("smss")
    end
  end
end