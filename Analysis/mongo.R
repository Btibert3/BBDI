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

## some constants
DB <- "bbdi"
COLLECTION <- "bbdi.bbdi"



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

## select all records (be careful when working with large datasets)
## differs from above - creates a cursor we need to iterate ?mongo.cursor
cursor <- mongo.find(mongo, "twitter.twitter")
tmp <- mongo.cursor.value(cursor)  ## first record
class(tmp)
tmp <- mongo.bson.to.list(tmp)
names(tmp)

## from help, when doing a query, we need to iterate using the cursor
twts <- list()
while (mongo.cursor.next(cursor)) {
  tmp <- mongo.bson.to.list(mongo.cursor.value(cursor))
  tmp <- list(tmp)
  twts <- c(twts, tmp)
}

## CODE NOTE WORKING ABOVE BUT WHY?

mongo.disconnect(mongo)