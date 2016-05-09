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

CMD /bin/bash
