#!/bin/bash

COMMAND=$1

stackname="my-rest-api"
message="Usage: $0 [build | clean | deploy | package ]"

case $COMMAND in
    build)
        make all
        ;;
    clean)
        make clean
        ;;
    delete)
         aws cloudformation delete-stack --stack-name $stackname
        ;; 
    deploy)
        aws cloudformation deploy --stack-name $stackname --template-file ./build/restapi/packaged-template.yml --capabilities CAPABILITY_IAM
        ;;
    package)
        aws cloudformation package --template sam-template.yml --s3-bucket mylambda-deployment --output-template-file ./build/restapi/packaged-template.yml
        ;;
    *)
        echo $message
        ;;
esac