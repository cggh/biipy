# biipy
Docker image for bioinformatics analysis.

To run:
> docker pull cggh/biipy
> docker run -d -v ${HOME}/git/ag1000g:/ag1000g -p 31778:8888 -v /data:/data --name ipag2 cggh/biipy:latest

