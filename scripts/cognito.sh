#!/bin/bash

COMMAND=$1

stackname="my-user-pool"
message="Usage: $0 [create | delete]"

case $COMMAND in
    create)
        aws cloudformation create-stack --stack-name $stackname --template-body file://deployment/cognito.yml --capabilities CAPABILITY_AUTO_EXPAND 
        ;;
    delete)
        aws cloudformation delete-stack --stack-name $stackname
        ;;
    *)
        echo $message
        ;;
esac