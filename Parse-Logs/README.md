# About This Code

The python script `parse-mongo.py` will find the twitter logs that match a certain pattern and read/parse each valid tweet into a MongoDB database called BBDI and a collection (table) called BBDI as well.  The benefit of this approach is that the full response from the API is stored, allowing us to query all aspects of the tweet, including valuable metadata.

You will need to install an external python library, `pymongo` which was created by the developers of MongoDB.  This provides us with an API within python to interact with the database.  With `easy install`, installation is simple at the command line:

```
sudo easy_install pymongo
```

Further details on installation can be found [here](http://api.mongodb.org/python/current/installation.html).


To run the script, use the command line and navigate to the directory where you saved the python script.  For example:

```
cd bbdi/code-samples
python parse-mongo.py
```



## Tweaks
By no means is this a production-worthy program, but it does the job.  To customize this for your own needs, please take note of the following:

- Change the code to point to the directory where the twitter logs are located
- Change the pattern variable to identify the file(s) you are interested in collecting

## Watchouts
- Make sure that you have the MongoDB server running on your local machine
- I would recommend opening the script