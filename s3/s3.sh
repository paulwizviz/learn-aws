#!/bin/bash

if [ "$(basename $(realpath .))" != "learn-aws" ]; then
    echo "You are outside the scope of the project"
    exit 0
fi

COMMAND=$1

message="Usage: $0 [create | delete]"

case $COMMAND in
    create)
        aws cloudformation create-stack --stack-name MyLambda-DeployBucket --template-body file://s3.yml --capabilities CAPABILITY_AUTO_EXPAND
        ;;
    delete)
        aws cloudformation delete-stack --stack-name MyLambda-DeployBucket
        ;;
    *)
        echo $message
        ;;
esac