FROM ubuntu:20.04
LABEL maintainer="ma3av020@gmail.com", version="1.3"
ENV DEBIAN_FRONTEND=noninteractive
RUN apt-get update && \
	apt-get install --no-install-recommends -y \
	git \
	cmake \
	libusb-1.0-0-dev \
	build-essential \
	libopencv-dev \ 
	libpcl-dev \
	pcl-tools 

RUN apt-get install --no-install-recommends -y ca-certificates
RUN git clone --branch=plane_segm https://github.com/person1of2interest/peac plane_segm
RUN cd ./plane_segm/cpp && \
	mkdir build && \
	cd build && \
	cmake .. && \
	cp ../plane_fitter_pcd.ini . && \
	make 


#To build and run the docker image, do this:

#docker build -t [name] [path]
#xhost +
#docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -it [name]:latest /bin/bash
#cd ./plane_segm/cpp/build
#./plane_fitter_pcd

#To exit, enter "exit" in the terminal

