# biipy
Docker image for bioinformatics analysis.

To run:

    docker pull cggh/biipy
    XSOCK=/tmp/.X11-unix/X0
    docker run -d \
      -v ${HOME}/git/ag1000g:/ag1000g \
      -v /data:/data \
      -v $XSOCK:$XSOCK \
      -p 31778:8888 \
      --name biipy cggh/biipy:latest

`-v` Maps a volume to the instance. Here we have two flags, one for code and one for data.

`-p` Maps a port on your system to the default of 8888 for the biipy instance
