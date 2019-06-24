#!/bin/bash

. scripts/utils.sh


CHANNEL=$1
CHANNEL=$2

if [ "$CHANNEL" == "" -o "$CHANNEL" == "" ]; then
    echo "!!!!!!!!!!!!!!! peer=$peer,org=$org !!!!!!!!!!!!!!!!"
    echo "========= ERROR !!! the peer is required ==========="
    echo
    exit 1
fi

setOrdererGlobals

echo "CHANNEL"

peer channel fetch config config_block.pb -o orderer.example.com:7050 -c $CHANNEL --cafile $ORDERER_CA
set +x
else
set -x
peer channel fetch config config_block.pb -o orderer.example.com:7050 -c $CHANNEL --tls --cafile $ORDERER_CA
set +x
fi

echo "Decoding config block to JSON and isolating config to ${OUTPUT}"
set -x
configtxlator proto_decode --input config_block.pb --type common.Block | jq .data.data[0].payload.data.config >"${OUTPUT}"
set +x

peer channel join -b mychannel.block

