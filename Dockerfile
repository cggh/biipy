FROM cggh/biipy_base:0.1
MAINTAINER Nicholas Harding <njh@well.ox.ac.uk>

ENV DEBIAN_FRONTEND noninteractive

# Add custom install scripts
RUN mkdir /biipy
ADD ./install /biipy/install

# Install basemap
RUN /biipy/install/basemap.sh

# Install TreeMix
RUN /biipy/install/treemix.sh

# Install APE
RUN R -e 'install.packages("ape", repos="http://cran.us.r-project.org")'

# Install more python libraries
ENV HDF5_DIR /usr/lib/x86_64-linux-gnu/hdf5/serial
RUN python3.5 -m pip install --no-cache-dir \
    h5py=="2.6.0" \
    tables=="3.2.2" \
    bcolz=="1.0.0" \
    rpy2=="2.7.8" \
    statsmodels=="0.6.1" \
    scikit-learn=="0.17.1" \
    seaborn=="0.7.0" \
    bokeh=="0.11.1" \
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
    psutil=="4.1.0" \
    toolz=="0.7.4" \
    dask=="0.8.2" \
    zarr=="0.3.0" \
    biopython=="1.66" \
    pyfasta=="0.5.2" \
    pysam=="0.8.4" \
    PyVCF=="0.6.7" \
    ete3=="3.0.0b29" \
    msprime=="0.1.10" \
    py-cpuinfo=="0.1.8" \
    prettypandas=="0.0.2" \
    joblib=="0.9.4" \
    fastcluster=="1.1.20"

# Install more python libraries
RUN python3.5 -m pip install --no-cache-dir \
    vcfnp=="2.2.0" \
    pysamstats=="0.24.2" \
    anhima=="0.11.2" \
    zarr=="0.4.0" \
    scikit-allel=="0.20.3"

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
