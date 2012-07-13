require 'mysql'

def connect(host = 'localhost', user = 'root', password = '',database = 'welcu')

	connection = Mysql.new(host,user)
	connection.select_db(database)
	return connection
end

def search_tweets(connection, query_term)
	sql = 'Select * from tweets where query_id = (select id from queries where query = "%22'+query_term.split(" ").join("%20")+'%22");'
	print sql
	result = connection.query(sql)
	print "searching for tweets\n"
	tweets = []
	result.each do |row|
		tweets.push(row[1])
	end
	return tweets
end