#!/usr/bin/env sh

# load/memuat env variabel yang ada pada file .env
export $(grep -v '^#' .env | xargs)

# declare variabel yang dibutuhkan
TAG="latest"
USERNAME="ahmadxgani"
IMAGE_NAME="karsajobs:${TAG}"
NAMESPACED_IMAGE_NAME="ghcr.io/${USERNAME}/${IMAGE_NAME}"

# build image dari dockerfile
echo "build docker"
docker build -t $IMAGE_NAME . 

echo "============================================================"
# mengubah nama image yang sudah di buat ke nama image sesuai dengan ketentuan nama yang akan di push ke repository 
echo "rename docker image"
docker tag $IMAGE_NAME $NAMESPACED_IMAGE_NAME

echo "============================================================"
# login ke github container registry menggunakan classic token yang sudah di set di .env sebelum nya
echo "login ke github container registry"
echo $CR_PAT | docker login ghcr.io -u $USERNAME --password-stdin

echo "============================================================"
# push image yang sudah di rename ke github container registry
echo "push ke github container registry"
docker push $NAMESPACED_IMAGE_NAME