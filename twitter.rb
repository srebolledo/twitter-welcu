require 'tweets_helper'
require 'database_helper'
require 'rubygems' #used by json/pure
require 'json' #used to parse json
require 'htmlentities'
htmlent = HTMLEntities.new

query_term = ""
args = []
ARGV.each do |arg|
	i=0
	if arg.class != nil
		args.push("%22" + arg.split(" ").join("%20").to_s+ "%22")
	end
end
query_term = args.join('%20').to_s
print "Query: " + query_term+ "\n"
query_term = htmlent.encode(query_term)
print "Query: " + query_term+ "\n"

tweets = get_tweet(query_term)
max_id = print_tweets(tweets)
print "El maximo id fue " + max_id.to_s + "\n"
#max_od = print_tweets(get_tweet("hola",max_id))
#print "El maximo id fue " + max_id.to_s + "\n"
