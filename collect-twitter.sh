#! /bin/bash
# remove the lines below here before running------
# Example 7: connect into the twitter firehouse - best approach is to use Command Line - run in Ubuntu 11.10
#      Attempted to do this within R, but different approaches proved computing resources get consumed at incredible rate
# need to make this file executable from a command line in a linux-type environment (run in Ubuntu) by chmod 755
# saves datafile every hour (closes curl, reopens curl) from the twitter sample firehouse, raw json, should be able to process raw data in R and elsewhere
# If you're already in the directory containing the file you could just type: ./filename.sh and press Enter.

while true; do
    curl -s -m 3600 -u twitterusername:twitterpassword https://stream.twitter.com/1/statuses/sample.json -o "twtstream_$(date +%Y%m%d%H).txt"
done
