#!/bin/bash
#
####################################################
#                                                  #
# Crawls home-owners twitter account, and mails me #
# if there's a new tweet about the Innsbruckweg.   #
#                                                  #
####################################################
#
# Store directory this script is located
DIR="$( cd "$( dirname "$0" )" && pwd )"
#
# Download all tweets from "Swart Bedrijfshuisvesting".
wget -O $DIR/swartbhv.xml https://twitter.com/statuses/user_timeline/swartbhv.xml?count=10
#
# Copy all lines with sting "Innsbruckweg" in seperate file.
grep -i innsbruckweg $DIR/swartbhv.xml > $DIR/innsbruckwegNew
#
# If tweets about the Innsbruckweg have changed, or if new tweets are added, mail me
cmp $DIR/innsbruckwegOld $DIR/innsbruckwegNew
if [ $? -ge 1 ]; then
	sendemail -f xuvu75on@kpnmail.nl -t arnodebruijn@hotmail.com -u "Innsbruckweg TWEET-ALERT" -m "New tweet - http://twitter.com/#!/swartbhv" -s mail.kpnmail.nl
	cp $DIR/innsbruckwegNew $DIR/innsbruckwegOld
fi
