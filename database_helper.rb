require 'mysql'
def connect(host, user, password,database = 'welcu')

	connection = Mysql.new(host,user)
	connection.select_db(database)
	return connection


end