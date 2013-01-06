
## import our modules -- may need to install first
from pymongo import MongoClient
import json
import os
import time
import datetime


## setup the directory info
os.chdir('/home/brock/datasets/election2012')
path =  os.getcwd()


## create a python list that stores the subset of files we want to parse
## http://www.regular-expressions.info/reference.html
pattern = '_10222012'
files = [f for f in os.listdir(path) if pattern in f]


## setup the connection to mongodb
conn = MongoClient()
#conn.database_names()


## create the twitter database -- created if it doesnt exist
db = conn['bbdi']

## loop and insert for 
start = datetime.datetime.now()
for log in files:
    ## print status
    print "parsing file " + log + " at " + time.ctime()
    ## read in the records
    with open(log) as file:
        nn = 0
        for line in file:
            twt = json.loads(line)
            if 'text' in twt:
                db.bbdi.insert(twt)
                nn = nn + 1
        print "number of inserts = " + str(nn)
end = datetime.datetime.now()

print end-start


