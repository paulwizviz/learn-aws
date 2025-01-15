#!/bin/bash

if [ "$(basename $(realpath .))" != "learn-aws" ]; then
    echo "You are outside the scope of the project"
    exit 0
fi

export NETWORK_NAME="learn-aws_iam"

COMMAND=$1

case $COMMAND in
    "start")
        docker compose -f ./iam/docker-compose.yaml up
        ;;
    "stop")
        docker compose -f ./docker-compose.yaml down
        ;;
    *)
        echo "Usage: $0 [ start | stop ]"
        ;;
esac