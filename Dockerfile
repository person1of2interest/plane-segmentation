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
RUN git clone --branch=fixes https://github.com/person1of2interest/peac plane_segm
#To build and run the docker image, do this:
#sudo docker build -t [name] [path]
#sudo docker run -it [name] /bin/bash
#To exit, enter "exit" in the terminal
RUN cd ./plane_segm/cpp && \
	mkdir build && \
	cd build && \
	cmake .. && \
	cp ../plane_fitter_pcd.ini . && \
	make 
#CMD cd ./plane_segm/cpp/build && \
#	./plane_fitter_pcd
#RUN pcl-viewer ../../data/stair/output/record_00080.seg.pcd


