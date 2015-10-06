# biipy
Docker image for bioinformatics analysis.

To run:

    docker pull cggh/biipy
    version=v0.6
    image=cggh/biipy:$version
    XSOCK=/tmp/.X11-unix/X0
    docker run \
      -it \
      --rm \
      -v ${HOME}:/home \
      -v /data:/data \
      -v $XSOCK:$XSOCK \
      -p 31778:8888 \
      --name biipy_$version \
      --env "docker_image=$image" \
      $image

`-v` Maps a volume to the instance. Here we have two flags, one for home directory and one for data.

`-p` Maps a port on your system to the default of 8888 for the biipy instance
