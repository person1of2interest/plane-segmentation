plane-segmentation
==================

Overview
--------

This is an extension to the project for extracting planes from organized point clouds, which is based on this data https://github.com/ai4ce/peac. 

We also thank https://github.com/blurgyy for the great contribution to correcting the shortcomings.

There are following files in this package:
  * Dockerfile
     
     This is a dockerfile that contains all the necessary libraries to reproduce the work of the algorithm. Ubuntu 20.04 is used as the basis for the docker image.

Installation
------------

1)Make sure you have downloaded everything you need to work with docker images.

2)Build the given dockerfile and run the docker image.
  
  For ubuntu, you need to enter the following commands in the terminal:
  
  ```
  docker build -t [name] [path] 
  xhost +
  docker run -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -it [name]:latest /bin/bash
  ```

3)Then run "plane_fitter_pcd"
  
  ```
  cd ./plane_segm/cpp/build
  ./plane_fitter_pcd
  ```

Using
-----

1)To open ".png" files use ```xdg-open [filename]```

2)To open ".pcd" files use ```pcl-viewer [filename]```
  
