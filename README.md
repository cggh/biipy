# biipy
## About
Docker image for *bi*oinformatics *i*n *py*thon.

Includes a number of popular libraries and dependencies for genetic data analysis in ipython. See Dockerfile for details.

## Run

To run:

    version=v1.1.0
    image=cggh/biipy:$version
    docker pull $image
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

`-v` maps a volume to the instance. Here we have two flags, one for home directory and one for data.

`-p` maps a port on your system to the default of 8888 for the biipy instance.

## Release policy

- Minor changes to Dockerfile that do not add, remove or alter dependencies (e.g., change ordering) get a micro version bump, e.g., 0.1.0 -> 0.1.1.

- Adding, removing or changing (e.g., upgrading) a dependency in the Dockerfile gets a minor version bump, e.g., 0.1 -> 0.2.

- Changing the base image (e.g., to a different version of Ubuntu) gets a major version bump, e.g., 0.1 -> 1.0

## Further info
For some information on how to set up on your system, see [here](http://hardingnj.github.io/Using-docker/)

[@hardingnj](https://github.com/hardingnj) & [@alimanfoo](https://github.com/alimanfoo)
