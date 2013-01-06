# -*- coding: utf-8 -*-
# <nbformat>3.0</nbformat>

# <codecell>

tweets = []

##add some dicts to the list
tweets.append({'text':'this is some text'})
tweets.append({'text':'this has the wrong #hashtag'})
tweets.append({'text':'this is what we are looking for #election'})
tweets

# <codecell>

for tweet in tweets:
    print tweet.keys()

# <codecell>

for tweet in tweets:
    print tweet.values()

# <codecell>

## a foor loop to store only the tweets with the hashtag we want
election = []
tag = 'election'

for tweet in tweets:
    if tag in tweet['text']:
        print 'yes'
        election.append(tweet)
    else:
        print 'no'

# <codecell>

election

