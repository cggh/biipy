# biipy
Docker image for bioinformatics analysis.

To run:

    docker pull cggh/biipy
    docker run -d \
      -v ${HOME}/git/ag1000g:/ag1000g \
      -v /data:/data \
      -p 31778:8888 \
      --name biipy cggh/biipy:latest

`-v` Maps a volume to the instance. Here we have two flags, one for code and one for data.
`-p` Maps a port on your system to the default of 8888 for the biipy instance
