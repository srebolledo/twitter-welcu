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
	queries = queries_count()
	tmp = []
	tabla = ""
	queries.each do |query|
		# print query
		query["query"].gsub!("%20"," ")
		query["query"].gsub!("%22"," ")
		# tmp.push(query)
		tabla = tabla + "<tr><td>" + query["query"] + "</td><td>" + query["veces"]+"</td></tr>"

	end
	"<h1>Searching queries</h1>" +
	"Add yours in localhost:4567/search/your search query<br>
	<table><tr><th>Query</th><th>Count</th></tr>" + tabla + "</table>"
end


get '/show/:name/?' do |n|

	connection = connect()
	tweets = search_tweets(connection,n.downcase)
	 "<h1>Your tweets for \"" + n + " \" search are</h1>" +
	"<table><tr><td>" + tweets.join("</td></tr><tr><td>") + "</td></tr></table>"

end