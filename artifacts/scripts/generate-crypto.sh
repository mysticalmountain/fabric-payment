#!/bin/bash
export PATH=${PWD}/../bin:${PWD}:$PATH
echo "generate crypto config begin"
cryptogen generate --config=./crypto-config.yaml
echo "generate crypto config end"
