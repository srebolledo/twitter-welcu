require 'rubygems'
require 'sinatra'
require 'database_helper'
get '/' do
	"For the search, use localhost:4567/search/query_term1/query_term2"
end

get '/search/*/?' do |n|
	search_term = "%22" + n.split(" ").join("%20").split("/").join("%22%20%22") + "%22"
	search_term = search_term.downcase
	add_search(search_term)
	status, headers, body = call env.merge("PATH_INFO" => '/show/queries')
  	[status, headers, body.map(&:downcase)]

end

get '/show/queries/?' do |n|
	queries = search_queries()
	tmp = []
	queries.each do |query|
		print query
		query.gsub!("%20"," ")
		query.gsub!("%22"," ")
		tmp.push(query)
	end
	queries = tmp
	"<h1>Searching queries</h1>" +
	"Add one with /search/your_search<br>
	<table><tr><td>" + queries.join("</td></tr><tr><td>") + "</td></tr></table>"
end


get '/show/:name/?' do |n|

	connection = connect()
	tweets = search_tweets(connection,n.downcase)
	 "<h1>Your tweets for \"" + n + " \" search are</h1>" +
	"<table><tr><td>" + tweets.join("</td></tr><tr><td>") + "</td></tr></table>"

end