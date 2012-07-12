require 'net/http'
#Function get_tweet, it receives a search term and returns a hash containing the data
def get_tweet(search,since_id = 0, throtle = 20)
	url = 'http://search.twitter.com/search.json?q='+search+'&rpp='+throtle.to_s+'&since_id='+since_id.to_s
	print "Asking with this url " + url
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
				ids.push(tweet['id_str'].to_i)
			end
		end
	end
	return ids.max
end