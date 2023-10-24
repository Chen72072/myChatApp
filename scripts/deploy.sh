#!/bin/bash

# check the variable from the user
if [ $# -eq 2 ]; then
    if docker image inspect myimage:$1 ; then
        echo "image $1 exists!!! you want to rebuild it? (y/n)"
        read -n 1 ans
        if [[ $ans == 'y' ]]; then
            docker image rm myimage:$1
            echo "Deleting existing image..."
            # build the image
            docker build -t myimage .
            echo "build"
            # create docker tag
            docker image tag myimage myimage:$1
            echo "tag"
        fi
    else
        # image does not exist
        echo "Image $1 does not exist. Building it now..."

        # build the image
        docker build -t myimage .
        echo "build"
        # create docker tag
        docker image tag myimage myimage:$1
        echo "tag"
    fi

    echo "Do you want to push the image to the Artifact Registry repository? (y/n)"
    read -n 1 push

    if [[ $push == "y" ]]; then

        # Get the service account key
        gcloud config set auth/impersonate_service_account artifact-admin-sa@grunitech-mid-project.iam.gserviceaccount.com

        gcloud auth configure-docker me-west1-docker.pkg.dev
        
        docker tag myimage:$1 me-west1-docker.pkg.dev/grunitech-mid-project/chanicohen-chat-app-images/myimage:$1

        docker push me-west1-docker.pkg.dev/grunitech-mid-project/chanicohen-chat-app-images/myimage:$1
    fi

else
    echo "ERROR - i need two argoment"
fi