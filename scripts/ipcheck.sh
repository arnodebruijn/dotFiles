#!/bin/bash
#
####################################################
#                                                  #
# Checks to see if the external ip changed,        #
# if so I receive an e-mail                        #
#                                                  #
####################################################
#
DOMAIN=kastanjeplein.de-bruijn.nu
IPFILE=/home/arno/scripts/.externalIP
CURRENT_IP=$(curl -s checkip.dyndns.com | grep -Eo "[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+")

if [ -f $IPFILE ]; then
KNOWN_IP=$(cat $IPFILE)
else
KNOWN_IP=
fi

if [ "$CURRENT_IP" != "$KNOWN_IP" ]; then
echo $CURRENT_IP > $IPFILE

MAIL_SUBJECT="IP address for $DOMAIN  has changed"
MAIL_BODY="The IP address for $DOMAIN has been changed to $CURRENT_IP. Please change the nameserver records at https://www.satserver.nl/ accordingly."

sendmail -f logs@pchulp-op-afstand.nl -t arnodebruijn@gmail.com -u $MAIL_SUBJECT -m $MAIL_BODY -s smtp.pchulp-op-afstand.nl
logger -t ipcheck -- IP changed to $CURRENT_IP
else
logger -t ipcheck -- No IP change
fi
