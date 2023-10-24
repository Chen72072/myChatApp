#!/bin/bash

version='latest'

if [ $# -ne 0 ]; then
    version=$1
    gcloud artifacts registries Docker pull chanicohen-chat-app-images myimage:$1
    echo "pull....."
    docker run -d -p -v chat-app-data:/chatApp/data -p 5000:5000 --name ChatAppRun gcr.io/${gcloud config get-value project}/myimage:$version
else
    docker volume create chat-app-data
    docker build -t myimage:${version} .
    docker run -d -p -v chat-app-data:/chatApp/data -p 5000:5000 --name ChatAppRun myimage:${version}
fi

#!/bin/bash

version=$1

if [ $# -ne 0 ]; then
# אם קיבלנו ארגומנט, זה אומר שאנחנו רוצים למשוך את הגרסה הספציפית הזו מהארטיפקט
gcloud artifacts registries Docker pull chanicohen-chat-app-images myimage:versionecho"pull....."dockerrun−d−p−vchat−app−data:/chatApp/data−p5000:5000−−nameChatAppRungcr.io/{gcloud config get-value project}/myimage:$version
else
# אם לא קיבלנו ארגומנט, זה אומר שאנחנו רוצים לבנות את הגרסה האחרונה על המכונה הווירטואלית
version=$(gcloud artifacts registries Docker list --filter="tags=latest" --repository=chanicohen-chat-app-images | tail -1 | awk '{print $1}')
echo "version: version"dockervolumecreatechat−app−datadockerbuild−tmyimage:{version} .
docker run -d -p -v chat-app-data:/chatApp/data -p 5000:5000 --name ChatAppRun gcr.io/${gcloud config get-value project}/myimage:$version
fi


# docker build -t myimage:${version} .
# docker run -d -p 5000:5000 --name ChatAppRun myimage:${version}

#docker volume create my-volume
#run the container
#docker run -p 5000:5000 -v my-volume:/code my-chat-app
#ran the container with limit cpu and memory
#docker run -it --ulimits nproc=1 --memory=1G my-container

#ran the large Dockerfile
#docker run -it --ulimits nproc=1 --memory=2G my-container