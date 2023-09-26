#!/bin/bash

# check the variable from the user
if [ $# -eq 2 ]; then
    # create a git tag
    git tag -a $1 -m $2
    git push --tags

    # build the image
    docker build -t myimage .
    echo "build"
    # create docker tag
    docker image tag myimage myimage:$1
    echo "tag"
    # run the image
    docker run -d -p 5000:5000 myimage 
    echo "Good"
else
    echo "ERROR - i need two argoment"
fi