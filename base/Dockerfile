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

# install miniconda
RUN curl -LO https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash Miniconda3-latest-Linux-x86_64.sh -b -p /miniconda
ENV PATH /miniconda/bin:$PATH

RUN conda update -y conda
# conda with python 3.5
RUN conda create --name science --yes python=3.5.1
RUN source activate science
RUN pip install -v --no-binary=:all: numpy=="1.11.0" scipy=="0.17.0"

ADD package_list.txt .
RUN conda install --name science --file package_list.txt --yes
RUN conda install -n science -c anaconda ipython=4.2.0 --yes
RUN conda info --envs

CMD /bin/bash
