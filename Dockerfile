FROM cggh/biipy_base:latest
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

# Install more python libraries via conda
ENV HDF5_DIR /usr/lib/x86_64-linux-gnu/hdf5/serial
ADD conda_package_list.txt .
RUN conda install -c anaconda -c bioconda -c r \
  --file conda_package_list.txt --name science --yes 

# not needed??
#RUN source activate /miniconda/envs/science
RUN conda info --envs

# Install more python libraries via pip. Versions not on conda.
ADD pypi_package_list.txt .
RUN pip install --no-cache-dir -r pypi_package_list.txt


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
