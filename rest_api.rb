require 'rubygems'
require 'sinatra'
require 'database_helper'
get '/' do
	"For the search, use localhost:4567/search/query_term1/query_term2"
end

get '/search/:name/?' do |n|
	"The query term is " + n
end

get '/show/:name/?' do |n|

	connection = connect()
	tweets = search_tweets(connection,n.downcase)
	 "<h1>Your tweets for \"" + n + " \" search are</h1>" +
	"<table><tr><td>" + tweets.join("</td></tr><tr><td>") + "</td></tr></table>"

end