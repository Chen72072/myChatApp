#!/bin/bash

# Stop all running containers
docker stop $(docker ps -a -q)

if [ $# -eq 0 ]; then
    docker rmi -f myimage
else
    docker rmi -f myimage:$1
fi
    docker rm -f ChatAppRun

docker system prune --volumes -f

# Remove all stopped containers
# docker rm $(docker ps -a -q)

# #Remove volume my volume
# docker volume remove my-volume

# # Remove all images
# docker rmi -f $(docker images -a -q)

# # remove all images which are not used by existing containers
# docker image prune -a

