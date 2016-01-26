# biipy
## About
Docker image for *bi*oinformatics *i*n *py*thon.

Includes a number of popular libraries and dependencies for bioinformatic data 
analysis in Python. See the [Dockerfile](Dockerfile) for details of which 
software libraries are included.

## Prerequisites

[Install docker](https://docs.docker.com/engine/installation/) on your host 
system and make sure you can [run docker commands as a non-root 
user](https://docs.docker.com/engine/installation/ubuntulinux/#create-a-docker-group) 
(i.e., add yourself to the docker group).

## Running commands

To run a single command using the biipy docker image, for convenience a 
[biipy_run.sh](biipy_run.sh) wrapper script is available from this 
repository. 

For example, save [biipy_run.sh](biipy_run.sh) to a local file on your host 
system, then run:

    $ ./biipy_run.sh v1.6.0 ipython
    
This will run a docker container using the biipy image and execute an IPython 
shell.

To run a Jupyter notebook server, omit the last argument, e.g.:

    $ ./biipy_run.sh v1.6.0

You will probably want to map more directories from your host filesystem 
into the container, and may want to change other settings such as the 
default port mapping for the Jupyter notebook server, in which case you can 
edit and customise your local copy of the biipy_run.sh script.

If you have a Jupyter notebook server already running and want to also run 
other commands using the same container, find out the container name:

    $ docker ps
    CONTAINER ID        IMAGE                    COMMAND                CREATED             STATUS              PORTS                    NAMES
    fb030ddae198        cggh/biipy:v1.6.0        "/bin/bash /biipy/no   10 seconds ago      Up 10 seconds       0.0.0.0:8888->8888/tcp   aliman_biipy_v1.6.0

...then use docker exec, e.g.:

    $ docker exec -it aliman_biipy_v1.6.0 ipython
    
You can also use this as a quick way to install additional software into a 
running container if you need to, e.g.:

    $ docker exec -it --user=root aliman_biipy_v1.6.0 pip3 install somepackage

## Customising the Jupyter notebook server

By default, biipy will run a Jupyter notebook server with default settings. 
You can change the Jupyter configuration by creating and editing a 
configuration file. This is useful, e.g., if you want to secure the notebook
server with HTTPS and a password (highly recommended).

To generate a default configuration file, do e.g.:

    $ ./biipy_run.sh v1.6.0 jupyter notebook --generate-config
    Writing default config to: /home/aliman/.jupyter/jupyter_notebook_config.py

You can then edit the configuration file on the host system, assuming you 
have mapped your home directory into the container. For example, here are the 
lines I have uncommented and edited in mine:

    $ grep '^[^#]' .jupyter/jupyter_notebook_config.py 
    c.NotebookApp.allow_origin = '*'
    c.NotebookApp.certfile = 'mycert.pem'
    c.NotebookApp.cookie_secret = b'...'
    c.NotebookApp.enable_mathjax = False
    c.NotebookApp.ip = '*'
    c.NotebookApp.open_browser = False
    c.NotebookApp.password = 'sha1:...'
    c.NotebookApp.port = 8888

You will want to replace the ``cookie_secret`` and ``password`` variables 
with something different. To generate an SHA1 hash of your password, run an 
IPython interactive shell:

    $ ./biipy_run.sh v1.6.0 ipython

...then do:

    In [1]: from notebook.auth import passwd; passwd()

...and copy-paste the SHA1 string into the config file.

Further instructions on setting up HTTPS and other matters relating to 
securing a notebook server are available from the [Jupyter docs]
(http://jupyter-notebook.readthedocs.org/en/latest/public_server.html).

If you have mapped your home directory as a volume and are running biipy 
with your own UID, then Jupyter *should* pick up the changes you have made 
to the configuration file the next time you run the notebook server.

## Contributing

If there are features you would like to add or other changes you'd like to 
make, please feel free to [raise an issue on GitHub](https://github.com/cggh/biipy/issues/new) 
or create a pull request.

## Release policy

- Minor changes to Dockerfile that do not add, remove or alter dependencies 
  (e.g., change ordering) get a micro version bump, e.g., 0.1.0 -> 0.1.1.

- Adding, removing or changing (e.g., upgrading) a dependency in the Dockerfile 
  gets a minor version bump, e.g., 0.1 -> 0.2.

- Changing the base image (e.g., to a different version of Ubuntu) gets a major 
  version bump, e.g., 0.1 -> 1.0

## Known issues

- For some reason that we don't yet understand, if you try to run a Jupyter 
  notebook server by providing the command directly (e.g., 
  ``biipy_run.sh v1.6.0 jupyter notebook``), this leads to kernel connection 
  issues. However, there is a bash script baked into the container that works,
  e.g., ``biipy_run.sh v1.6.0 /biipy/scripts/notebook.sh``. This is the default 
  command in the image so you can just run ``biipy_run.sh v1.6.0`` also.

## Further info

For some information on how to set up on your system, see [here](http://hardingnj.github.io/Using-docker/)

[@hardingnj](https://github.com/hardingnj) & [@alimanfoo](https://github.com/alimanfoo)

## Release notes

### v1.6.0

- Add sudo, nano Ubuntu packages.
- Add psutil, py-cpuinfo, prettypandas, joblib Python packages.
- Minor changes to biipy_run.sh example script to enable better mapping of user 
  information into containers.

### v1.5.0

- Reorganise Dockerfile and minimise dependencies installed to reduce image size.

### v1.4.0

- Upgrade pysamstats.

### v1.3.0

- Add bokeh, numba, zarr, openblas.
- Upgrade numpy (and should now build against openblas), Jupyter notebook, 
  IPython, rpy2, matplotlib, sqlalchemy, pymysql, openpyxl, pillow, 
  memory_profiler, psutil, msprime, anhima, dask, ete3.
