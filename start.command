#!/bin/bash
echo "start command"

#開発元が未確認→セキュリティとプライバシーで開く設定
SCRIPT_DIR=$(cd $(dirname $0); pwd)
IMAGE_NAME=nodecg_image
CONTAINER_NAME=nodecg1

EXISTS_IMAGE=$(docker images -q ${IMAGE_NAME})
if [ ! -n "${EXISTS_IMAGE}" ]; then
    echo "build nodecg image"
    docker build -t ${IMAGE_NAME} ${SCRIPT_DIR}
fi

EXISTS_CONTAINER=$(docker container ls -q -a -f name=${CONTAINER_NAME})
RUNNINNG_CONTAINER=$(docker container ls -q -f name=${CONTAINER_NAME})
if [ ! -n "${EXISTS_CONTAINER}" ]; then
    echo "run nodecg container"
    docker run -p 9090:9090 -v ${SCRIPT_DIR}/bundles:/usr/src/app/bundles --name ${CONTAINER_NAME} ${IMAGE_NAME}
else
    if [ -n "${RUNNINNG_CONTAINER}" ]; then
        echo "restart nodecg container"
        docker restart ${CONTAINER_NAME}
    else
        echo "start nodecg container"
        docker start ${CONTAINER_NAME}
    fi
fi

echo "finish command"