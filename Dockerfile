FROM ubuntu:14.04
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
RUN apt-get update && apt-get install -y \
    fonts-liberation \
    fonts-dejavu \
    ttf-ubuntu-font-family
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get -y install ttf-mscorefonts-installer

# install R for RPY2
RUN echo "deb http://cran.fhcrc.org/bin/linux/ubuntu trusty/" | tee -a /etc/apt/sources.list > /dev/null
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN add-apt-repository ppa:marutter/rdev
RUN apt-get update -y && apt-get install -y r-base r-base-dev

# install APE
RUN R -e 'install.packages("ape", repos="http://cran.us.r-project.org")'

# install BWA & SAMTOOLS
RUN apt-get update && apt-get install -y samtools bwa

# HDF5
RUN apt-get update && apt-get install -y libhdf5-dev libhdf5-serial-dev

# PYTHON 3
RUN apt-get update && apt-get install -y \
    python3-dev \
    libpq-dev \
    python3-numpy-dbg python3-numpy \
    python3-pyqt5 python3-pyqt4 \
    python3-lxml \
    python3-pip
RUN pip3 install -U pip setuptools

# DEPENDENCIES FOR ETE3
ENV LICENSE accept
RUN curl -L -O http://downloads.sourceforge.net/project/pyqt/sip/sip-4.16.9/sip-4.16.9.tar.gz
RUN tar -xvzf sip-4.16.9.tar.gz
RUN cd sip-4.16.9 && python3 configure.py && make && make install
RUN curl -L -O http://sourceforge.net/projects/pyqt/files/PyQt4/PyQt-4.11.4/PyQt-x11-gpl-4.11.4.tar.gz
RUN tar -xvzf PyQt-x11-gpl-4.11.4.tar.gz

# PYTHON LIBRARIES
RUN pip3 install cython=="0.23.4"
RUN pip3 install numpy=="1.10.1"
RUN pip3 install scipy=="0.16.1"
RUN pip3 install numexpr=="2.4.6"
RUN pip3 install -v h5py=="2.5.0" 
RUN pip3 install tables=="3.2.2"
RUN pip3 install bcolz=="0.12.0"
RUN pip3 install pandas=="0.17.1"
RUN pip3 install IPython=="4.0.1"
RUN pip3 install jupyter=="1.0.0"
RUN pip3 install rpy2=="2.7.4"
RUN pip3 install statsmodels=="0.6.1"
RUN pip3 install scikit-learn=="0.17"
RUN pip3 install matplotlib=="1.5.0"
RUN pip3 install seaborn=="0.6.0"
RUN pip3 install matplotlib_venn=="0.11.1"
RUN pip3 install sh=="1.11"
RUN pip3 install sqlalchemy=="1.0.9"
RUN pip3 install pymysql=="0.6.7"
RUN pip3 install psycopg2=="2.6.1"
RUN pip3 install petl=="1.0.11"
RUN pip3 install petlx=="1.0.3"
RUN pip3 install humanize=="0.5.1"
RUN pip3 install pillow=="3.0.0"
RUN pip3 install IntervalTree=="2.1.0"

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
RUN cd basemap-1.0.7 && python3 setup.py install

# install TreeMix
RUN apt-get install -y gsl-bin libgsl0-dev libboost-all-dev
RUN curl -OL https://bitbucket.org/nygcresearch/treemix/downloads/treemix-1.12.tar.gz
RUN tar zvxf treemix-1.12.tar.gz
RUN cd treemix-1.12 && ./configure && make && make install

# PYTHON BIO LIBRARIES
RUN pip3 install biopython=="1.66"
RUN pip3 install pyfasta=="0.5.2"
RUN pip3 install pysam=="0.8.4"
RUN pip3 install pysamstats=="0.23"
RUN pip3 install PyVCF=="0.6.7"
RUN pip3 install anhima=="0.11.1"
RUN pip3 install line_profiler=="1.0"
RUN pip3 install memory_profiler=="0.39"
RUN pip3 install psutil=="3.3.0"
RUN pip3 install --upgrade  https://github.com/jhcepas/ete/archive/3.0.zip
RUN pip3 install vcfnp=="2.2.0"
RUN pip3 install toolz=="0.7.4"
RUN pip3 install dask[complete]=="0.7.5"
RUN pip3 install scikit-allel=="0.18.1"

EXPOSE 8888
ADD ./notebook.sh /notebook.sh
ADD ./test.py /test.py
RUN python3 /test.py

CMD ["/bin/bash", "notebook.sh"]
