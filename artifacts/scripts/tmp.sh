#!/bin/bash

export PATH=${PWD}/../../bin:${PWD}:$PATH
export FABRIC_CFG_PATH=${PWD}
export VERBOSE=false

echo "========================"

echo $PATH

docker exec cli ./scripts/create-channel.sh mychannel
if [ $? -ne 0 ]; then
    echo "ERROR !!!! Test failed"
    exit 1
fi
echo "------------------------"
