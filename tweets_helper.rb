require 'net/http'
require 'rubygems' #used by json/pure
require 'json' #used to parse json
require 'htmlentities'

#Function get_tweet, it receives a search term and returns a hash containing the data
def get_tweet(search,since_id = 0, throtle = 20)
	url = 'http://search.twitter.com/search.json?q='+search+'&rpp='+throtle.to_s+'&since_id='+since_id.to_s
	print "Asking with this url " + url+ "\n"
	resp = Net::HTTP.get_response(URI.parse(url))
	response_array = JSON.parse(resp.body)
end

def print_tweets(tweets_hash)
	ids = []
	tweets_hash.each_pair do |key,value|
		#print key +"   ====>  "+ value.to_s
		if key == "results"
			i = 0
			value.each do |tweet|
				print tweet['id_str'] + " " +tweet['text'] + "\n"
				ids.push(tweet['id_str'])
			end
		end
	end

	return ids.max
end

def save_tweets(tweets_hash,query_id,connection)
	ids = []
	htmlent = HTMLEntities.new
	tweets_hash.each_pair do |key,value|
		#print key +"   ====>  "+ value.to_s
		if key == "results"
			i = 0
			value.each do |tweet|
				sql = "insert into tweets values ('"+tweet['id_str']+"','"+htmlent.encode(tweet['text'])+"','"+htmlent.encode(tweet['from_user'])+"','"+query_id+"');"
				connection.query(sql)
			end
		end
	end
end