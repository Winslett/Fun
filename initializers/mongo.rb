require 'uri'

db_name = $1 if ENV['MONGOHQ_URL'] =~ /\/([^\/]+)$/

$conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'], :logger => Logger.new(File.dirname(__FILE__) + "/../logs/mongo.yml"))
$db = $conn.db(db_name)
