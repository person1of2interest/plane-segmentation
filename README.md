plane-segmentation
==================

Overview
--------

This is an extension to the project for extracting planes from organized point clouds, which is based on this data https://github.com/ai4ce/peac. 

We also thank https://github.com/blurgyy for the great contribution to correcting the shortcomings.

There are following folders and files in this package:
 
  * setup-scripts
  
     It contains everything you need to build and run the project.
     
      * Dockerfile
     
        This is a dockerfile that contains all the necessary libraries to reproduce the work of the algorithm (https://github.com/ai4ce/peac) ON THE ORIGINAL DATA. Ubuntu 20.04 is used as the basis for the docker image.
        
     To process your files, use the following two scripts:
     
     * install.sh
      
        This is a bash script that installs the required libraries and clones folders.
        
     * run.sh
     
        This is a bash script that runs the algorithm (https://github.com/ai4ce/peac) and post-processing.
        At the input, it accepts the path to the folder with the files that need to be processed, and returns the path to the folder with already processed files with refined planes.
        
     
  * notebooks
  
     These are notebooks that do the post-processing portions of the planes separately. 
     
     Namely: 
     
     * get_sep_plane.ipynb extracts planes from the file resulting from the execution of the algorithm (https://github.com/ai4ce/peac) into separate files.
     
     * RANSAC.ipynb applies linear regression and RANSAC methods to a single plane and visualizes the results.
     
  * gspr.py
  
     This is a Python script that processes the segmented planes file resulting from the algorithm (https://github.com/ai4ce/peac) and refines the planes.

Installation
------------

* Dockerfile
   
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

2)To open ".pcd" files use ```pcl_viewer [filename]```
  
