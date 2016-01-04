# biipy
# Docker image for bioinformatics analysis.
# This is an *example* run script

biipy_version=v1.2.0
docker pull cggh/biipy:${biipy_version}

XSOCK=/tmp/.X11-unix/X0
uid=$(id -u)

docker run -d \
  -v ${HOME}:/home \
  -v /data:/data \
  -v $XSOCK:$XSOCK \
  -p 31778:8888 \
  --name biipy_$biipy_version \
  -e "docker_image=$biipy_version" \
  -u ${uid} \
  cggh/biipy:${biipy_version}
