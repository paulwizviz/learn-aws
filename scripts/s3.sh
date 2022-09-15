#!/bin/bash

COMMAND=$1

message="Usage: $0 [create | delete]"

case $COMMAND in
    create)
        aws cloudformation create-stack --stack-name MyLambda-DeployBucket --template-body file://deployment/s3.yml --capabilities CAPABILITY_AUTO_EXPAND
        ;;
    delete)
        aws cloudformation delete-stack --stack-name MyLambda-DeployBucket
        ;;
    *)
        echo $message
        ;;
esac