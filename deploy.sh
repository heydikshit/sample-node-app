#!/bin/bash
set -e

echo "Logging in to ECR..."

aws ecr get-login-password --region ap-south-1 | sudo docker login \
  --username AWS \
  --password-stdin 800754315556.dkr.ecr.ap-south-1.amazonaws.com

echo "Pulling latest Docker image..."

sudo docker pull \
  800754315556.dkr.ecr.ap-south-1.amazonaws.com/sample-node-app:latest

echo "Stopping old container..."

sudo docker stop sample-node-app || true
sudo docker rm sample-node-app || true

echo "Starting new container..."

sudo docker run -d \
  --restart unless-stopped \
  -p 8080:8080 \
  --name sample-node-app \
  800754315556.dkr.ecr.ap-south-1.amazonaws.com/sample-node-app:latest

echo "Deployment successful!"
