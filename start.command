#途中
docker build -t nodecg $PWD
if !(docker container ls -q -a -f name=nodecg-lab)
    docker run -p 9090:9090 -v $PWD/bundles:/usr/src/app/bundles --name nodecg-lab nodecg
fi