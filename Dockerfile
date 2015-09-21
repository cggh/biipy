FROM ubuntu:14.04
MAINTAINER Nicholas Harding <njh@well.ox.ac.uk>

# INSTALL R for RPY2
RUN apt-get install -y software-properties-common
RUN echo "deb http://cran.fhcrc.org/bin/linux/ubuntu trusty/" | tee -a /etc/apt/sources.list > /dev/null
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9
RUN add-apt-repository ppa:marutter/rdev
RUN apt-get update -y
RUN apt-get upgrade -y
RUN apt-get install -y r-base r-base-dev

# BWA & SAMTOOLS
RUN apt-get install -y samtools bwa
RUN apt-get install -y libhdf5-serial-dev

# PYTHON 3
RUN apt-get install -y libpq-dev
RUN apt-get install -y python3-pip

RUN pip3 install \
  numpy \
  scikit-allel \
  cython=="0.23.1" \
  numexpr=="2.4.3" 

RUN pip3 install \
  tables=="3.2.0" \
  bcolz=="0.9.0" \
  pandas=="0.16.2" \
  IPython=="3.2.0" \
  rpy2=="2.6.0" \
  statsmodels=="0.6.1" \
  sklearn \
  sh=="1.11" \
  sqlalchemy=="1.0.6" \
  pymysql=="0.6.6" \
  psycopg2=="2.6.1" \
  petl=="1.0.11" \
  humanize

RUN apt-get install -y libfreetype6-dev libxft-dev

RUN pip3 install \
  matplotlib=="1.4.3" \
  seaborn=="0.6.0" \
  biopython=="1.65" \
  pyfasta \
  pysam=="0.8.3" \
  petlx=="1.0.3" \
  PyVCF=="0.6.7"

RUN pip3 install \
  pysamstats=="0.23"

RUN pip3 install \
  scipy=="0.16.0"

RUN apt-get install -y python3-numpy-dbg python3-numpy
RUN pip3 install \
  anhima \
  matplotlib_venn \
  vcfnp 

RUN apt-get install -y libhdf5-dev
RUN pip3 install \
  h5py=="2.5.0" 

RUN pip3 install \
  pyzmq \
  jinja2 \
  tornado \
  jsonschema

RUN apt-get install -y git python3-pyqt5 python3-pyqt4

# ETE3 (likely to change in future)
RUN pip3 install --upgrade  https://github.com/jhcepas/ete/archive/3.0.zip

EXPOSE 8888
ADD ./notebook.sh /notebook.sh
ADD ./test.py /test.py
RUN python3 /test.py
CMD ["/bin/bash", "notebook.sh"]
