#!/bin/bash

#chmod +x install.sh

#apt-get update
#apt-get install --no-install-recommends -y \
	#git \
	#cmake \
	#libusb-1.0-0-dev \
	#build-essential \
	#libopencv-dev \
	#libpcl-dev \
	#pcl-tools \
	#ca-certificates

#apt-get install --no-install-recommends -y ca-certificates

git clone --branch=ps_min https://github.com/person1of2interest/peac plane_segm
mkdir plane_segm/data

