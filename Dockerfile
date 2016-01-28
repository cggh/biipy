FROM ubuntu:15.10
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
RUN python3.5 -m pip install -U pip setuptools wheel

# Add custom install scripts
RUN mkdir /biipy
ADD ./install /biipy/install

# Install base python libraries
RUN python3.5 -m pip install --no-cache-dir cython=="0.23.4"
RUN python3.5 -m pip install --no-cache-dir numpy=="1.10.4"
RUN python3.5 -m pip install --no-cache-dir lxml=="3.5.0"
RUN python3.5 -m pip install --no-cache-dir scipy=="0.16.1"
RUN python3.5 -m pip install --no-cache-dir pandas=="0.17.1"
RUN python3.5 -m pip install --no-cache-dir matplotlib=="1.5.1"
RUN python3.5 -m pip install --no-cache-dir numexpr=="2.4.6"
RUN python3.5 -m pip install --no-cache-dir llvmlite=="0.8.0"
RUN python3.5 -m pip install --no-cache-dir numba=="0.23.0"
RUN python3.5 -m pip install --no-cache-dir ipython[all]=="4.0.3"
RUN python3.5 -m pip install --no-cache-dir jupyter=="1.0.0"

# Install basemap
RUN /biipy/install/basemap.sh

# Install TreeMix
RUN /biipy/install/treemix.sh

# Install APE
RUN R -e 'install.packages("ape", repos="http://cran.us.r-project.org")'

# Install more python libraries
ENV HDF5_DIR /usr/lib/x86_64-linux-gnu/hdf5/serial
RUN python3.5 -m pip install --no-cache-dir \
    h5py=="2.5.0" \
    tables=="3.2.2" \
    bcolz=="0.12.1" \
    rpy2=="2.7.7" \
    statsmodels=="0.6.1" \
    scikit-learn=="0.17" \
    seaborn=="0.7.0" \
    bokeh=="0.11.0" \
    matplotlib_venn=="0.11.1" \
    sh=="1.11" \
    sqlalchemy=="1.0.11" \
    pymysql=="0.7.1" \
    psycopg2=="2.6.1" \
    openpyxl=="2.3.3" \
    xlrd=="0.9.4" \
    xlwt-future=="0.8.0" \
    whoosh=="2.7.0" \
    petl=="1.1.0" \
    petlx=="1.0.3" \
    humanize=="0.5.1" \
    pillow=="3.1.0" \
    IntervalTree=="2.1.0" \
    line_profiler=="1.0" \
    memory_profiler=="0.41" \
    psutil=="3.4.2" \
    toolz=="0.7.4" \
    dask=="0.7.6" \
    zarr=="0.3.0" \
    biopython=="1.66" \
    pyfasta=="0.5.2" \
    pysam=="0.8.4" \
    PyVCF=="0.6.7" \
    ete3=="3.0.0b29" \
    msprime=="0.1.7" \
    py-cpuinfo=="0.1.8" \
    prettypandas=="0.0.2" \
    joblib=="0.9.4" \
    fastcluster=="1.1.20"

# Install more python libraries
RUN python3.5 -m pip install --no-cache-dir \
    vcfnp=="2.2.0" \
    pysamstats=="0.24.2" \
    anhima=="0.11.2" \
    scikit-allel=="0.20.2"

ENV DISPLAY :0
ENV QT_X11_NO_MITSHM 1
EXPOSE 8888
ADD ./test.py /biipy/test.py
RUN python3.5 /biipy/test.py
ADD ./test.ipynb /biipy/test.ipynb
ADD ./scripts /biipy/scripts
ADD ./version /biipy/version
RUN chmod -R 775 /biipy
CMD /biipy/scripts/notebook.sh
