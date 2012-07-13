require 'tweets_helper'
require 'database_helper'
require 'htmlentities'

#connecting to database
database = connect('localhost','root','')
htmlent = HTMLEntities.new #used to clean the input received by the console.
#The next part is the arguments that we receive by the console args.
#It will parse them and preserve all the possible ", ' and special chars.
query_term = ""
args = []
ARGV.each do |arg|
	i=0
	if arg.class != nil
		args.push("%22" + arg.split(" ").join("%20").to_s+ "%22")
	end
end
query_term = args.join('%20').to_s
query_term = htmlent.encode(query_term)
print "The query is: " + query_term+ "\n"
#End for parsing and joining the query_term for the search api in twitter

#Max_id is the highest id that we collect from twitter if the query was asked before
max_id = "0"
#checking if the query_term exists in the database before.
result = database.query("select * from queries where query = '"+query_term.to_s+"' limit 1;")
fields = result.fetch_hash
print fields
if fields.nil?
	database.query('insert into queries values (NULL,"0","'+query_term+'","1")')
	print "Saving the query in database\n"	
	#Saving query_term in the database
	result = database.query('select LAST_INSERT_ID() as lastId;')
	fields = result.fetch_hash
	lastId = fields["lastId"]

else
	max_id = fields['last_id']
	print "MAX_ID : "+max_id
	print "Reading max_id from database\n"
	lastId = fields['id'] 
end

tweets = get_tweet(query_term,max_id,20)
max_id = print_tweets(tweets)
save_tweets(tweets,lastId,database)
if max_id.nil?
	print "There's no new tweets. Yipee!"
else
	database.query('update welcu.queries set last_id = "'+max_id.to_s+'" where id = "'+lastId.to_s+'" ;')

end
#updating the max_id in the query
