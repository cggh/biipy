# biipy
#Docker image for bioinformatics analysis.

biipy_version=v0.5
docker pull cggh/biipy:${biipy_version}
XSOCK=/tmp/.X11-unix/X0
docker run -d \
  -v ${HOME}:/home \
  -v /data:/data \
  -v $XSOCK:$XSOCK \
  -p 31778:8888 \
  --name biipy_$biipy_version \
  -e "docker_image=$biipy_version" \
  cggh/biipy:${biipy_version}
