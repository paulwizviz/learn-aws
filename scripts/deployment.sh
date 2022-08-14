#!/bin/bash

COMMAND=$1

message="Usage: $0 [cognito | s3]"

case $COMMAND in
    cognito)
        aws cloudformation create-stack --stack-name MyUserPool --template-body file://deployment/cf/cognito.yml --capabilities CAPABILITY_AUTO_EXPAND --parameters ParameterKey=CognitoDomain,ParameterValue=myidentity
        ;;
    s3)
        aws cloudformation create-stack --stack-name MyLambda-DeployBucket --template-body file://deployment/cf/s3.yml --capabilities CAPABILITY_AUTO_EXPAND
        ;;
    *)
        echo $message
        ;;
esac