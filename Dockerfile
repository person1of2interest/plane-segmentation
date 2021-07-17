FROM ubuntu:20.04
LABEL maintainer="ma3av020@gmail.com", version="1.3"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
	apt-get install -y \
	git \
	cmake \
	libusb-1.0-0-dev \
	build-essential \
	libopencv-dev \ 
	libpcl-dev \
	pcl-tools \
	#libboost-all-dev 
RUN git clone --branch=fixes https://github.com/person1of2interest/peac plane_segm
#To build and run the docker image, do this:
#sudo docker build -t [name] [path]
#sudo docker run -it [name] /bin/bash
#To exit, enter "exit" in the terminal


