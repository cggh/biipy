# python standard library
import sys
# ensure Python 3.4
assert sys.version_info[0:2] == (3, 4), sys.version_info
import os
import operator
import itertools
import collections
import functools
import glob
import csv
import datetime
import bisect
import sqlite3
import subprocess
import random
import gc
import shutil
import shelve
import contextlib

# general purpose third party packages

import cython
assert cython.__version__ == '0.23.1', cython.__version__ 

import numpy as np
assert np.__version__ == '1.9.3', np.__version__ 
nnz = np.count_nonzero

import scipy
assert scipy.__version__ == '0.16.0', scipy.__version__ 
import scipy.stats
import scipy.spatial.distance

import numexpr
assert numexpr.__version__ == '2.4.3', numexpr.__version__ 

import h5py
assert h5py.__version__ == '2.5.0', h5py.__version__ 

import tables
assert tables.__version__ == '3.2.1.1', tables.__version__ 

import bcolz
assert bcolz.__version__ == '0.10.0', bcolz.__version__ 

import pandas
assert pandas.__version__ == '0.16.2', pandas.__version__ 

import IPython
assert IPython.__version__ == '4.0.0', IPython.__version__ 
# from IPython.html.widgets import interact, interactive
# from IPython.html import widgets
from IPython.display import clear_output, display, HTML

import rpy2
assert rpy2.__version__ == '2.6.2', rpy2.__version__ 
import rpy2.robjects as ro

import statsmodels
assert statsmodels.__version__ == '0.6.1', statsmodels.__version__ 

import sklearn
assert sklearn.__version__ == '0.16.1', sklearn.__version__ 
import sklearn.decomposition
import sklearn.manifold

import sh
assert sh.__version__ == '1.11', sh.__version__ 

import sqlalchemy
assert sqlalchemy.__version__ == '1.0.8', sqlalchemy.__version__ 

import pymysql
assert pymysql.__version__ == '0.6.6.None', pymysql.__version__ 

import psycopg2
assert psycopg2.__version__ == '2.6.1 (dt dec pq3 ext lo64)', psycopg2.__version__ 

import petl as etl
assert etl.__version__ == '1.0.11', etl.__version__ 
etl.config.display_index_header = True

import humanize
# VERSION (0, 4) doesn't match PyPI (0.5.1)
from humanize import naturalsize, intcomma, intword

# plotting setup
import matplotlib as mpl
assert mpl.__version__ == '1.4.3', mpl.__version__ 
import matplotlib.pyplot as plt
from matplotlib.colors import ListedColormap
from matplotlib.gridspec import GridSpec

import matplotlib_venn as venn

import seaborn as sns
assert sns.__version__ == '0.6.0', sns.__version__ 

# bio third party packages

import Bio
assert Bio.__version__ == '1.65', Bio.__version__ 

import pyfasta
# no version identifier, cannot verify version

import pysam
assert pysam.__version__ == '0.8.3', pysam.__version__ 

import pysamstats
assert pysamstats.__version__ == '0.23', pysamstats.__version__ 

import petlx
assert petlx.__version__ == '1.0.3', petlx.__version__ 
import petlx.bio

import vcf
assert vcf.VERSION == '0.6.7', vcf.VERSION 

import vcfnp
assert vcfnp.__version__ == '2.1.5', vcfnp.__version__ 

import anhima
assert anhima.__version__ == '0.11.1', anhima.__version__ 

from mpl_toolkits.basemap import Basemap

import allel
# be flexible about version
print('allel', allel.__version__)
