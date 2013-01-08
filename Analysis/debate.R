###############################################################################
## Use R to do a quick and dirty analysis on the 1-day's worth of twitter data
## that is stored in the local MongoDB
##
## help
## http://brockt.tumblr.com/post/35055958195/getting-started-with-mongodb-on-mac-osx
## http://docs.mongodb.org/manual/reference/sql-comparison/
###############################################################################

## load the r mongo package
library(rmongodb)
library(stringr)
library(plyr)

## some constants so we can save on typing
DB <- "bbdi"
COLLECTION <- "bbdi.bbdi"
PATTERN <- "#debate"

###############################################################################
## Connect and Play around with some data in R
###############################################################################

## connect - I am using the mongodb running on another machine at home
mongo <- mongo.create("192.168.1.69")
mongo.is.connected(mongo)

## confirm that we see data
mongo.get.databases(mongo)
mongo.get.database.collections(mongo, DB)

## select 1 record -- see help above for SQL mapping
mongo.count(mongo, "bbdi.bbdi")
tmp <- mongo.find.one(mongo, COLLECTION)
class(tmp) # what do we have?
tmp <- mongo.bson.to.list(tmp) # convert to a list
class(tmp)
names(tmp) # what metadata do we have
tmp$text # show the text


###############################################################################
## Iterate over the data and store the tweets
###############################################################################

## create a data frame to store our data
tweets <- data.frame(stringsAsFactors=F)

## selects all records in collection - not ideal, but search stuff in docs
## differs from above - creates a cursor we need to iterate ?mongo.cursor
cursor <- mongo.find(mongo, COLLECTION)

## from help, when doing a query, we need to iterate using the cursor
## iterate and put the results into the tweets dataframe
start = Sys.time()
while (mongo.cursor.next(cursor)) {
  twt <- mongo.bson.to.list(mongo.cursor.value(cursor))
  time = strptime(twt$created_at, "%a %b %e %H:%M:%S %z %Y", tz="GMT")
  tweet <- data.frame(id = twt$id_str,
                      user = twt$user$screen_name,
                      tweet = twt$text,
                      time = time,
                      debate_ind = str_detect(tolower(twt$text), PATTERN),
                      stringsAsFactors=F)
  tweets <- rbind.fill(tweets, tweet, stringsAsFactors=F)
}
end = Sys.time()
end - start

## destroy the cursor
mongo.cursor.destroy(cursor)

## close the connection
mongo.disconnect(mongo)

