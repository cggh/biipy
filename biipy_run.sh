#!/bin/bash

# This is an example wrapper script for running commands using the cggh/biipy
# docker container.

# First script argument should be biipy version, e.g., "v1.3.0".
VERSION=$1

# Further script arguments (optional) should be command to run plus any
# arguments.
shift

# This is the docker image we will use.
DOCKER_IMAGE=cggh/biipy:${VERSION}

exec docker run \
    --interactive \
    --tty \
    --rm \
    --user=${UID} \
    --env="HOME" \
    --env="DISPLAY" \
    --env="DOCKER_IMAGE=${DOCKER_IMAGE}" \
    --env="USER=${USER}" \
    --volume="${HOME}:${HOME}:rw" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    --workdir="${HOME}" \
    --publish=8888:8888 \
    --name=${USER}_biipy_${VERSION} \
    ${DOCKER_IMAGE} \
    "$@"

# Add further --volume mappings if you want the container to have access to
# other directories on the host filesystem.
