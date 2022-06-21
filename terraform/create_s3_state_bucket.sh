#!/bin/bash

export REGION=us-east-1
export BUCKET=ex-state-bucket
export PROFILE=orca



BUCKET_EXISTS=$(aws s3api list-buckets --query "Buckets[].Name" --region $REGION --profile $PROFILE | grep $BUCKET > /dev/null 2>&1 ; echo $?)

[ "$BUCKET_EXISTS" != "0" ] &&  aws s3api create-bucket --bucket $BUCKET --region $REGION --profile $PROFILE
