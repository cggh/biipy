FROM ubuntu:16.04
MAINTAINER Nicholas Harding <njh@well.ox.ac.uk>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    software-properties-common \
    build-essential

RUN add-apt-repository multiverse
RUN echo ttf-mscorefonts-installer msttcorefonts/accepted-mscorefonts-eula select true | debconf-set-selections

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
    samtools \
    bwa \
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

# Upgrade pip etc.
RUN python3.5 -m pip install -U setuptools wheel

# Install base python libraries
RUN python3.5 -m pip install --no-cache-dir cython=="0.24"
RUN python3.5 -m pip install --no-cache-dir numpy=="1.11.0"
RUN python3.5 -m pip install --no-cache-dir lxml=="3.6.0"
RUN python3.5 -m pip install --no-cache-dir scipy=="0.17.0"
RUN python3.5 -m pip install --no-cache-dir pandas=="0.18.0"
RUN python3.5 -m pip install --no-cache-dir matplotlib=="1.5.1"
RUN python3.5 -m pip install --no-cache-dir numexpr=="2.5.2"
RUN python3.5 -m pip install --no-cache-dir jupyter=="1.0.0"

RUN python3.5 -m pip install --no-cache-dir ipython[all]=="4.2.0"
RUN python3.5 -m pip install --no-cache-dir llvmlite=="0.10.0"
RUN python3.5 -m pip install --no-cache-dir numba=="0.25.0"
