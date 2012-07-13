require 'mysql'

def connect(host = 'localhost', user = 'root', password = '',database = 'welcu')

	connection = Mysql.new(host,user)
	connection.select_db(database)
	return connection
end

def search_tweets(query_term)
	connection = connect()
	sql = 'Select * from tweets where query_id = (select id from queries where query = "%22'+query_term.split(" ").join("%20")+'%22");'
	result = connection.query(sql)
	tweets = []
	result.each do |row|
		tweets.push(row[1])
	end
	return tweets
end

def search_queries()
	connection = connect()
	sql = "select query from queries"
	result = connection.query(sql)
	queries = []
	result.each do |row|
		queries.push(row[0])
	end
	return queries
end

def search_queries_with_id()
	connection = connect()
	sql = "select id,query,last_id from queries"
	result = connection.query(sql)
	queries = {}
	result.each do |row|
		query = {}
		query["query"] = row[1]
		query["last_id"] = row[2]
 		queries[row[0]] = query
	end
	return queries
end

def add_search(search_term)
	connection  = connect()
	sql = "select id from queries where query = '"+search_term+"'"
	result = connection.query(sql)
	fields = result.fetch_hash
	if fields.nil?
		sql = "insert into queries values (NULL, 0, '"+search_term+"', 0)"
		connection.query(sql)
	end

end