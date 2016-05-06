FROM ubuntu:16.04
MAINTAINER Nicholas Harding <njh@well.ox.ac.uk>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    build-essential

RUN add-apt-repository multiverse
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

# This line needed to allow running of source with conda
RUN rm /bin/sh && ln -s /bin/bash /bin/sh

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    sudo \
    nano \
    curl \
    git \
    htop \
    man \
    unzip \
    wget \
    zlib1g-dev \
    libfreetype6-dev \
    libxft-dev \
    x11-apps \
    fonts-liberation \
    fonts-dejavu \
    ttf-ubuntu-font-family \
    ttf-mscorefonts-installer \
    r-base \
    r-base-dev \
    libhdf5-dev \
    libhdf5-serial-dev \
    python3.5-dev \
    libpython3.5-dev \
    libpq-dev \
    gsl-bin \
    libgsl0-dev \
    libboost-graph-dev \
    libopenblas-base \
    libopenblas-dev \
    llvm-3.6-dev \
    llvm \
    libedit-dev \
    libxml2-dev \
    libxslt1-dev \
    libgeos-c1v5 \
    libgeos-dev \
    libgeos++-dev \
    python3-pip \
    python3-pyqt4

# install anaconda
RUN curl -L http://repo.continuum.io/archive/Anaconda3-4.0.0-Linux-x86_64.sh > \
  anaconda_setup.sh
RUN bash anaconda_setup.sh -b -p /anaconda
ENV PATH /anaconda/bin:$PATH

RUN conda update -y conda

# conda with python 3.5.1
RUN conda create --name science --yes python=3.5.1

RUN conda config --add channels r
RUN conda config --add channels bioconda

# python modules via conda
ENV HDF5_DIR /usr/lib/x86_64-linux-gnu/hdf5/serial
ADD conda_package_list.txt .
RUN conda install --name science --file conda_package_list.txt --yes

# install bwa & samtools from bioconda
RUN conda create --name bwa --yes bwa=0.7.13
RUN conda create --name samtools --yes samtools=1.3.1

# Add custom install scripts
RUN mkdir -p /etc/pki/tls/certs
RUN cp /etc/ssl/certs/ca-certificates.crt /etc/pki/tls/certs/ca-bundle.crt
RUN mkdir /biipy
ADD ./install /biipy/install

# Install TreeMix
RUN /biipy/install/treemix.sh

# Install APE
RUN R -e 'install.packages("ape", repos="http://cran.us.r-project.org")'

# Install additional python libraries via pip. Versions not on conda.
# try to do some of these via conda-skeleton/build in future
ADD pypi_package_list.txt .
RUN source activate science && \
  pip install --no-cache-dir -r pypi_package_list.txt

ENV DISPLAY :0
ENV QT_X11_NO_MITSHM 1
EXPOSE 8888
ADD ./test.py /biipy/test.py
RUN source activate science && python3.5 /biipy/test.py
ADD ./test.ipynb /biipy/test.ipynb
ADD ./scripts /biipy/scripts
ADD ./version /biipy/version
RUN chmod -R 775 /biipy
CMD /biipy/scripts/notebook.sh
