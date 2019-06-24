#!/bin/bash


peer=$1
org=$2
channel=$3

echo "peer=$peer"
echo "org=$org"

if [ "$peer" == "" -o "$org" == "" -o "$channel" == "" ]; then
    echo "!!!!!!!!!!!!!!! peer=$peer,org=$org, channel=$channel !!!!!!!!!!!!!!!!"
    echo "========= ERROR !!! the peer org channel are required ==========="
    echo
    exit 1
fi

. scripts/utils.sh
setGlobals $peer $org

CHANNEL_NAME=$channel

echo "CHANNEL_NAME=$channel"
echo "CORE_PEER_LOCALMSPID=$CORE_PEER_LOCALMSPID"
echo "CORE_PEER_TLS_ROOTCERT_FILE=$CORE_PEER_TLS_ROOTCERT_FILE"
echo "CORE_PEER_MSPCONFIGPATH=$CORE_PEER_MSPCONFIGPATH"
echo "CORE_PEER_ADDRESS=$CORE_PEER_ADDRESS"

peer chaincode query -C $CHANNEL_NAME -n test -c  '{"function":"initLedger","Args":[]}'


