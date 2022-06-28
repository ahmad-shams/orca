#!/bin/sh

DATABASE_URL=$(aws secretsmanager get-secret-value --secret-id  DATABASE_URL --query SecretString --output text)
docker pull 565105851053.dkr.ecr.us-east-1.amazonaws.com/orca_python_docker:latest

docker run  565105851053.dkr.ecr.us-east-1.amazonaws.com/orca_python_docker:latest