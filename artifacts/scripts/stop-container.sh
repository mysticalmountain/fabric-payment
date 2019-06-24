#!/bin/bash
echo "stop container begin"
export COMPOSE_PROJECT_NAME=payment
docker-compose -f docker-compose.yaml down 
docker rm $(docker ps -aq)
docker rmi -f $(docker images dev-* -q)
echo "stop container end"
