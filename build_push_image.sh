#!/bin/bash

# load/memuat env variabel yang ada pada file .env
export $(grep -v '^#' .env | xargs)

# declare variabel yang dibutuhkan
TAG="v1"
USERNAME="ahmadxgani"
IMAGE_NAME="item-app:${TAG}"
NAMESPACED_IMAGE_NAME="ghcr.io/${USERNAME}/${IMAGE_NAME}"

# membuat image docker
docker build -t $IMAGE_NAME .

# melihat list atau daftar images di lokal 
docker images

# rename nama image agar sesuai dengan format Github Registry
docker tag $IMAGE_NAME $NAMESPACED_IMAGE_NAME
# delete image yang sudah tidak dipakai lagi
docker rmi $IMAGE_NAME

# login ke Github Registry
echo $CR_PAT | docker login ghcr.io -u $USERNAME --password-stdin > /dev/null

# meng-unggah/upload image ke Github Registry
docker push $NAMESPACED_IMAGE_NAME