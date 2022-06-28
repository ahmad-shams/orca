#!/bin/sh

{
    DATABASE_URL=$(aws secretsmanager get-secret-value --secret-id  DATABASE_URL --query SecretString --output text)
    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 565105851053.dkr.ecr.us-east-1.amazonaws.com/orca_python_docker

    docker pull 565105851053.dkr.ecr.us-east-1.amazonaws.com/orca_python_docker:latest

    docker run  -p 80:5000 --env DATABASE_URL=postgres://${DATABASE_URL} 565105851053.dkr.ecr.us-east-1.amazonaws.com/orca_python_docker:latest

} | tee /tmp/run-docker.log
