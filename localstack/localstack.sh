#!/bin/bash

if [ "$(basename $(realpath .))" != "learn-aws" ]; then
    echo "You are outside the scope of the project"
    exit 0
fi

COMMAND=$1

case $COMMAND in
    "start")
        docker compose -f ./localstack/docker-compose.yaml up
        ;;
    "stop")
        docker compose -f ./localstack/docker-compose.yaml down
        ;;
    *)
        echo "Usage: $0 [start | stop]"
        ;;
esac