#!/bin/bash

# Copyright © 2019 Sharice Mayer and Chris Pherson
# mayers.research@gmail.com
# chris@techfocus.net
# [This program is licensed under the "MIT License"]
# Please see the file LICENSE in the source
# distribution of this software for license terms.

#######
# 02-tensorflowscript.py
####### 

# update and upgrade with apt-get before doing anything
printf "\n"
date
printf "\nUpdating and upgrading with apt-get\n\n"
sudo apt-get -y update
sudo apt-get -y upgrade
#time sudo apt-get -y dist-upgrade

# Adding packages!
# Install packages for tensorflow
printf "\n"
date
printf "\nInstalling packages for tensorflow\n\n"
printf "\napt-get install packages: \n\n"
##TODO: Update this list
##time sudo apt-get install -y apt-utils libatlas-base-dev libblas3 liblapack3 liblapack-dev libblas-dev gfortran python-tk build-essential cmake libgtk-3-dev libboost-all-dev libtool pkg-config autoconf automake python3-setuptools
sudo apt-get install -y apt-utils
sudo apt-get install -y libatlas-base-dev
sudo apt-get install -y libblas3
sudo apt-get install -y liblapack3
sudo apt-get install -y liblapack-dev
sudo apt-get install -y libblas-dev
sudo apt-get install -y gfortran
sudo apt-get install -y python-tk
sudo apt-get install -y build-essential
sudo apt-get install -y cmake
sudo apt-get install -y libgtk-3-dev
sudo apt-get install -y libboost-all-dev
sudo apt-get install -y libtool
sudo apt-get install -y pkg-config
sudo apt-get install -y autoconf
sudo apt-get install -y automake
sudo apt-get install -y python3-setuptools
sudo apt-get  install -y libxml2
# dependencies for pillow:
sudo apt-get install -y python-dev

printf "\n"
date
printf "\npip install packages: \n\n"
##TODO: Update this list
##time sudo pip install --upgrade setuptools cython scipy numpy scikit-image dlib imutils pillow lxml matplotlib jupyter-client
sudo pip install --upgrade setuptools
sudo pip install --upgrade cython
sudo pip install --upgrade scipy
sudo pip install --upgrade numpy
sudo pip install --upgrade dlib
sudo pip install --upgrade imutils
# dependencies for pillow:
sudo pip install --upgrade libtiff
sudo pip install --upgrade littlecms
sudo pip install --upgrade tk
sudo pip install pillow
sudo pip install --upgrade matplotlib
sudo pip install --upgrade jupyter-client

printf "\n"
date
printf "\npip3 install packages: \n\n"
##TODO: Update this list
##time sudo pip3 install --upgrade setuptools scipy numpy scikit-image dlib imutils pillow lxml jupyter matplotlib cython jupyter-client 
sudo pip3 install --upgrade setuptools
sudo pip3 install --upgrade scipy
sudo pip3 install --upgrade numpy
sudo pip3 install --upgrade scikit-image
# all installed up to here
sudo pip3 install --upgrade dlib
sudo pip3 install --upgrade imutils
sudo pip3 install --upgrade pillow
sudo pip3 install --upgrade lxml
sudo pip3 install --upgrade jupyter
sudo pip3 install --upgrade matplotlib
sudo pip3 install --upgrade cython
sudo pip3 install --upgrade jupyter-client

# remove unnecessary packages
##time sudo apt autoremove

####  IF THE BELOW METHOD DOESN"T WORK,
#     USE PIP INSTALL INSTEAD AT THIS POINT
#     script is found in 01opt-pipscript.sh

printf "\n Cloning Tensorflow from git repository \n\n"
date
printf "\n"
# Clone tensorflow from github for install using Docker container
git clone https://github.com/tensorflow/tensorflow.git
cd tensorflow


#https://storage.googleapis.com/tensorflow/raspberrypi/tensorflow-1.14.0-cp34-none-linux_armv7l.whl
printf "\n Use build script to launch a Docker container for compilation installing tensorflow \n\n"
date
printf "\n"
#Cross-compile the TensorFlow source code to build a Python pip package with ARMv7 NEON instructions
#that works on Raspberry Pi 2 and 3 devices.
#The build script launches a Docker container for compilation. 
#Choosing Python 3 for the target package
#In order to do python 2.7, follow tensorflow site instructions
CI_DOCKER_EXTRA_PARAMS="-e CI_BUILD_PYTHON=python3 -e CROSSTOOL_PYTHON_INCLUDE_PATH=/usr/include/python3.4" \
    tensorflow/tools/ci_build/ci_build.sh PI-PYTHON3 \
    tensorflow/tools/ci_build/pi/build_raspberry_pi.sh


printf "\n Installing Tensorflow Now \n\n"
date
printf "\n"
# now install tensorflow wheel
sudo pip3 install tensorflow-1.14.0-cp34-none-linux_armv7l.whl


# Run next script:
# Install opencv
#sudo sh 03-opencvscript.sh


