## example
## https://skyl.org/log/post/skyl/2011/12/use-python-to-store-data-from-twitters-streaming-api-in-mongodb/
## Need to have mongodb instance running on machine, and install pymongo and tweetstream packages for python
## On Mac/linux, python package installs are easy, Windows is a little more difficult.  Look to ActiveState for their version of python.

## import the libraries
import pymongo
import tweetstream


## setup the connection to mongodDB (must be running)
## create a bruins database (if one doesnt exist)
conn = pymongo.MongoClient()
db = conn.bruins

## setup the user credentials for twitter
user = ''
pwd = ''


## connect and save the tweets to bruins database in mongo
words = ['#bruins']
with tweetstream.FilterStream(user, pwd, track=words) as stream:
    for tweet in stream:
        if 'text' in tweet:
            db.tweets.save(tweet)
        

