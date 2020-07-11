#!/bin/bash

STACK_NAME=good-parts-aws
REGION=eu-west-1

EC2_INSTANCE_TYPE=t2.micro

echo -e "\n\n=== Deploying main.yml ==="
aws cloudformation deploy \
  --region $REGION \
  --stack-name=$STACK_NAME \
  --template-file=main.yml \
  --no-fail-on-empty-changeset \
  --capabilities CAPABILITY_NAMED_IAM \
  --parameter-overrides EC2InstanceType=$EC2_INSTANCE_TYPE

# If the deploy succeeded, show the DNS name of the created instance
if [ $? -eq 0 ]; then
  aws cloudformation list-exports \
    --query "Exports[?Name=='InstanceEndpoint'].Value"
fi
