#!/bin/bash

if [ -z "$1" ]
then
	echo -n "Enter the path to the folder with the source data relative to the current directory: "
	read source
else
	source=$1
fi

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
cp -r $source/* plane_segm/data
cd plane_segm/data
find . -type f -name "*.pcd" > list.txt

cd ../cpp 
mkdir build 
cd build 
cmake .. 
cp ../plane_fitter_pcd.ini . 
make 
./plane_fitter_pcd

cd ../../data

mkdir my_out
#echo $PWD
cd output
find . -type f -name "*.pcd" > ../names.txt

file="../names.txt"

for name in $(cat $file)
do
	python3 ../../../gspr.py $name
done 

echo "The output files are located in ./plane_segm/data/my_out"

rm -r ../output 
rm ../names.txt ../list.txt