FROM ubuntu:15.10
MAINTAINER Nicholas Harding <njh@well.ox.ac.uk>

# install various libraries and software
RUN apt-get update && apt-get install -y \
    software-properties-common \
    build-essential \
    byobu \
    curl \
    git \
    htop \
    man \
    unzip \
    vim \
    wget \
    emacs24-nox \
    qt4-qtconfig \
    libqt4-core \
    libqt4-gui \
    libqt4-dev \
    zlib1g-dev \
    libfreetype6-dev \
    libxft-dev \
    x11-apps
ENV DISPLAY :0

# install fonts
RUN apt-add-repository multiverse
RUN apt-get install -y \
    fonts-liberation \
    fonts-dejavu \
    ttf-ubuntu-font-family
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install ttf-mscorefonts-installer

# install R for RPY2
RUN apt-get update -y && apt-get install -y r-base r-base-dev

# install APE
RUN R -e 'install.packages("ape", repos="http://cran.us.r-project.org")'

# install BWA & SAMTOOLS
RUN apt-get install -y samtools bwa

# HDF5
RUN apt-get install -y libhdf5-dev libhdf5-serial-dev

# PYTHON 3.5
RUN apt-get install -y python3.5-dev libpython3.5-dev
RUN apt-get install -y libpq-dev python3-pyqt5 python3-pyqt4 python3-pip
RUN python3.5 -m pip install -U pip setuptools wheel

# DEPENDENCIES FOR ETE3
ENV LICENSE accept
RUN curl -L -O http://downloads.sourceforge.net/project/pyqt/sip/sip-4.16.9/sip-4.16.9.tar.gz
RUN tar -xvzf sip-4.16.9.tar.gz
RUN cd sip-4.16.9 && python3.5 configure.py && make && make install
RUN curl -L -O http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.4/PyQt-x11-gpl-4.11.4.tar.gz
RUN tar -xvzf PyQt-x11-gpl-4.11.4.tar.gz

# PYTHON LIBRARIES
RUN apt-get build-dep -y python3-numpy
RUN apt-get install -y python3-numpy
RUN python3.5 -m pip install cython=="0.23.4"
RUN python3.5 -m pip install numpy=="1.10.1"
RUN python3.5 -m pip install scipy=="0.16.1"
RUN python3.5 -m pip install numexpr=="2.4.6"
RUN HDF5_DIR=/usr/lib/x86_64-linux-gnu/hdf5/serial python3.5 -m pip install -v h5py=="2.5.0" 
RUN HDF5_DIR=/usr/lib/x86_64-linux-gnu/hdf5/serial python3.5 -m pip install -v tables=="3.2.2"
RUN python3.5 -m pip install bcolz=="0.12.1"
RUN python3.5 -m pip install pandas=="0.17.1"
RUN python3.5 -m pip install IPython=="4.0.1"
RUN python3.5 -m pip install jupyter=="1.0.0"
RUN python3.5 -m pip install rpy2=="2.7.4"
RUN python3.5 -m pip install statsmodels=="0.6.1"
RUN python3.5 -m pip install scikit-learn=="0.17"
RUN python3.5 -m pip install matplotlib=="1.5.0"
RUN python3.5 -m pip install seaborn=="0.6.0"
RUN python3.5 -m pip install matplotlib_venn=="0.11.1"
RUN python3.5 -m pip install sh=="1.11"
RUN python3.5 -m pip install sqlalchemy=="1.0.9"
RUN python3.5 -m pip install pymysql=="0.6.7"
RUN python3.5 -m pip install psycopg2=="2.6.1"
RUN apt-get build-dep -y python3-lxml
RUN python3.5 -m pip install lxml=="3.5.0"
RUN python3.5 -m pip install openpyxl=="2.3.1"
RUN python3.5 -m pip install xlrd=="0.9.4"
RUN python3.5 -m pip install xlwt-future=="0.8.0"
RUN python3.5 -m pip install whoosh=="2.7.0"
RUN python3.5 -m pip install petl=="1.0.11"
RUN python3.5 -m pip install petlx=="1.0.3"
RUN python3.5 -m pip install humanize=="0.5.1"
RUN python3.5 -m pip install pillow=="3.0.0"
RUN python3.5 -m pip install IntervalTree=="2.1.0"

# dl basemap
RUN curl -OL http://sourceforge.net/projects/matplotlib/files/matplotlib-toolkits/basemap-1.0.7/basemap-1.0.7.tar.gz
RUN tar -xvzf basemap-1.0.7.tar.gz 

# dl GEOS
RUN curl -O http://download.osgeo.org/geos/geos-3.5.0.tar.bz2
RUN bzip2 -d geos-3.5.0.tar.bz2 && tar -vxf geos-3.5.0.tar
ENV GEOS_DIR /usr/local
RUN cd geos-3.5.0 && ./configure --prefix=$GEOS_DIR && make
RUN cd geos-3.5.0 && make check && make install && cd ../ && rm -r geos-3.5.0
RUN ldconfig
RUN cd basemap-1.0.7 && python3.5 setup.py install

# install TreeMix
RUN apt-get install -y gsl-bin libgsl0-dev libboost-all-dev
RUN curl -OL https://bitbucket.org/nygcresearch/treemix/downloads/treemix-1.12.tar.gz
RUN tar zvxf treemix-1.12.tar.gz
RUN cd treemix-1.12 && ./configure && make && make install

# PYTHON BIO LIBRARIES
RUN python3.5 -m pip install biopython=="1.66"
RUN python3.5 -m pip install pyfasta=="0.5.2"
RUN python3.5 -m pip install pysam=="0.8.4"
RUN python3.5 -m pip install pysamstats=="0.24.1"
RUN python3.5 -m pip install PyVCF=="0.6.7"
RUN python3.5 -m pip install anhima=="0.11.1"
RUN python3.5 -m pip install line_profiler=="1.0"
RUN python3.5 -m pip install memory_profiler=="0.39"
RUN python3.5 -m pip install psutil=="3.3.0"
RUN python3.5 -m pip install --upgrade  https://github.com/jhcepas/ete/archive/3.0.zip
RUN python3.5 -m pip install vcfnp=="2.2.0"
RUN python3.5 -m pip install toolz=="0.7.4"
RUN python3.5 -m pip install git+https://github.com/blaze/dask.git@master
RUN python3.5 -m pip install scikit-allel=="0.20.0"
RUN python3.5 -m pip install msprime=="0.1.6"

EXPOSE 8888
ADD ./test.py /test.py
RUN python3.5 test.py
ADD ./notebook.sh /notebook.sh
CMD ["/bin/bash", "notebook.sh"]
