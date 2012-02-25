require 'uri'

db_name = $1 if ENV['MONGOHQ_URL'] =~ /\/([^\/]+)$/

$conn = Mongo::Connection.from_uri(ENV['MONGOHQ_URL'], :logger => Logger.new(STDOUT))
$db = $conn.db(db_name)
