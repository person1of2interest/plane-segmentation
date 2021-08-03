#!/bin/bash

#chmod +x run.sh

if [ -z "$1" ]
then
	echo -n "Enter the path to the folder with the source data relative to the current directory: "
	read -r source
else
	source=$1
fi

cp -r "$source"/* plane_segm/data
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
cd output
find . -type f -name "*.pcd" > ../names.txt

file="../names.txt"

while read -r name
do
	python3 ../../../gspr.py "$name"
done < "$file"

echo "The output files are located in ./plane_segm/data/my_out"

rm -r ../output 
rm ../names.txt ../list.txt