#!/usr/bin/env bash

set -xeuo pipefail

cd /biipy

export GEOS_DIR=/usr
source activate science
curl -OL http://sourceforge.net/projects/matplotlib/files/matplotlib-toolkits/basemap-1.0.7/basemap-1.0.7.tar.gz
tar -xzf basemap-1.0.7.tar.gz
cd basemap-1.0.7
python setup.py install
cd ..
rm -r basemap-1.0.7
