#!/usr/bin/env bash

set -xeuo pipefail

cd /biipy

curl -L -O http://downloads.sourceforge.net/project/pyqt/sip/sip-4.16.9/sip-4.16.9.tar.gz
tar -xzf sip-4.16.9.tar.gz
cd sip-4.16.9
python3.5 configure.py
make
make install
cd ..
rm -r sip-4.16.9

curl -L -O http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.4/PyQt-x11-gpl-4.11.4.tar.gz
tar -xzf PyQt-x11-gpl-4.11.4.tar.gz
cd PyQt-x11-gpl-4.11.4
python3.5 configure.py --confirm-license
make
make install
cd ..
rm -r PyQt-x11-gpl-4.11.4
