#!/usr/bin/env bash

set -xeuo pipefail

cd /biipy

curl -OL https://bitbucket.org/nygcresearch/treemix/downloads/treemix-1.12.tar.gz
tar zxf treemix-1.12.tar.gz
cd treemix-1.12
./configure
make
make install
# leave source in-place