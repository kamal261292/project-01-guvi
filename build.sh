#! /bin/bash

#define Variables

DOCKER_USERNAME="krtech26"
REPO_NAME="react-site-app"
IMAGE_NAME="$DOCKER_USERNAME/$REPO_NAME"
DEV_TAG="dev"
PROD_TAG="prod"

#build the docker image
echo " Building Docker Image..."
docker build -t $IMAGE_NAME:$DEV_TAG .

#Tag the image for Dev and Production
echo " Tagging the image for dev and production..."
docker tag $IMAGE_NAME:$DEV_TAG $IMAGE_NAME:$PROD_TAG

#push both tags to Docker hub
echo "pushing dev tag..."
docker push $IMAGE_NAME:$DEV_TAG

echo "Pushing prod tag.."
docker push $IMAGE_NAME:$PROD_TAG

echo " Done"





