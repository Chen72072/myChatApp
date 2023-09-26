#!/bin/bash

version='latest'

if [ $# -eq 0 ]; then
    version=$1
fi

docker volume create chat-app-data
docker build -t myimage:${version} .
docker run -d -v chat-app-data:/chatApp/data -p 5000:5000 --name ChatAppRun myimage:${version}

# docker build -t myimage:${version} .
# docker run -d -p 5000:5000 --name ChatAppRun myimage:${version}

#docker volume create my-volume
#run the container
#docker run -p 5000:5000 -v my-volume:/code my-chat-app
#ran the container with limit cpu and memory
#docker run -it --ulimits nproc=1 --memory=1G my-container

#ran the large Dockerfile
#docker run -it --ulimits nproc=1 --memory=2G my-container