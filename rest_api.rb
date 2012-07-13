require 'rubygems'
require 'sinatra'
require 'database_helper'
get '/' do
	"For the search, use localhost:4567/search/query_term1/query_term2"
end

get '/search/add_search' do
	"<form method = 'post' action = '/search/add_search'>
		Add query term<input type='text' name='query_term'>
		<input type='submit' value = 'send my query term'>
	</form>"
end

post '/search/add_search' do
	n = params[:query_term]
	search_term = "%22" + n.split(" ").join("%20").split("/").join("%22%20%22") + "%22"
	search_term = search_term.downcase
	add_search(search_term)
	"<html><head><script type='text/javascript'>window.location = '/show/queries'</script></head></html>"	
end

get '/search/*/?' do |n|
	search_term = "%22" + n.split(" ").join("%20").split("/").join("%22%20%22") + "%22"
	search_term = search_term.downcase
	add_search(search_term)
	status, headers, body = call env.merge("PATH_INFO" => '/show/queries')
  	[status, headers, body]

end


get '/show/queries/?' do |n|
	queries = search_queries()
	tmp = []
	tabla = ""
	queries.each do |query|
		# print query
		query.gsub!("%20"," ")
		query.gsub!("%22"," ")
		# tmp.push(query)
		tabla = tabla + "<tr><td>" + query + "</td></tr>"

	end
	"<h1>Searching queries</h1>" +
	"<a href='/search/add_search'>Add yours</a><br>
	<a href='/show/queries_stats'>View the stats for queries </a>
	<table><tr><th>Query</th></tr>" + tabla + "</table>"
end




get '/show/queries_stats/?' do |n|
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
	"<a href='/search/add_search'>Add yours</a><br>
	<a href='/search/queries'>View all queries </a><br>
	<table><tr><th>Query</th><th>Count</th></tr>" + tabla + "</table>"
end


get '/show/:name/?' do |n|

	connection = connect()
	tweets = search_tweets(connection,n.downcase)
	 "<h1>Your tweets for \"" + n + " \" search are</h1>" +
	"<table><tr><td>" + tweets.join("</td></tr><tr><td>") + "</td></tr></table>"

end