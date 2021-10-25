IMAGE_NAME=nodecg_image
CONTAINER_NAME=nodecg1

EXISTS_IMAGE=$(docker images | grep $IMAGE_NAME)
if [ -n "${EXISTS_CONTAINER}" ]; then
    docker build -t nodecg $PWD
fi


EXISTS_CONTAINER=$(docker container ls -a | grep ${CONTAINER_NAME})
if [ -n "${EXISTS_CONTAINER}" ]; then
    docker run -p 9090:9090 -v $PWD/bundles:/usr/src/app/bundles --name ${IMAGE_NAME} ${CONTAINER_NAME}
else
    docker start ${CONTAINER_NAME}
fi