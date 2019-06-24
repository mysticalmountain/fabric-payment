#!/bin/bash
export PATH=${PWD}/../bin:${PWD}:$PATH
echo "start container begin"
export COMPOSE_PROJECT_NAME=payment
export IMAGE_TAG=1.4.0
docker-compose -f docker-compose.yaml up  -d
echo "start container end"
