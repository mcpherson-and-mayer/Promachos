#!/bin/bash

# Copyright © 2019 Sharice Mayer and Chris Pherson
# mayers.research@gmail.com
# chris@techfocus.net
# [This program is licensed under the "MIT License"]
# Please see the file LICENSE in the source
# distribution of this software for license terms.

###################################################################################################
###################################################################################################

#######
# 00-vimscript.py
#######

# update and upgrade with apt-get before doing anything
printf "\nUpdating and upgrading with apt-get\n"
sudo apt-get -y update
sudo apt-get -y upgrade
#sudo apt-get -y dist-upgrade

# install vim since nano stinks
# --requires reboot!
printf "\nInstalling VIM\n"
sudo apt-get install vim

printf "\n------- Rebooting Now -------\n"
sudo reboot now

# Run next script for tensorflow install:
# TWO OPTIONS:

# 1. Build tensorflow from source
# https://www.tensorflow.org/install/source_rpi
# Install Docker:
#sudo sh 01opt-dockerscript.sh
# Then install tensorflow from container:
#sudo sh 02-tensorflowscript.sh

# 2. Install tensorflow with pip
# https://www.tensorflow.org/install/pip
# **THIS IS MY RECOMMENDED APPROACH
#sudo sh 01opt-pipscript.sh


###################################################################################################
###################################################################################################

#######
# 01opt-pipscript.py
#######

# 1. Install Python Development System:
#install python > 3.4

# install pip3

#install virtualenv
sudo pip3 install virtualenv

# check your versions:
python3 --version
pip3 --version
virtualenv --version

# for Raspian system:
sudo apt update
sudo apt install python3-dev python3-pip
sudo apt install libatlas-base-dev 
sudo pip3 install -U virtualenv

# 2. (Recommended) Create a Virtual Environment
# Create a new virtual environment by choosing a Python interpreter and 
# making a ./venv directory to hold it:
virtualenv --system-site-packages -p python3 ./venv

# Activate the virtual environment using a shell-specific command:
source ./venv/bin/activate  # sh, bash, ksh, or zsh

# When virtualenv is active, your shell prompt is prefixed with (venv).
# Install packages within a virtual environment without affecting the host system setup. 
# Start by upgrading pip:
sudo pip3 install --upgrade pip
sudo pip3 list

# And to exit virtualenv later:
#deactivate # Don't deactivate until after you're done with tensorflow


# 3. Install the TensorFlow pip package
# Choose a TensorFlow packages to install from PyPI:
# (I chose 'tensorflow', which gives the latest stable release for CPU only)

sudo pip3 install --upgrade tensorflow

# We ran into this error:
#Found existing installation: wrapt 1.10.11
#ERROR: Cannot uninstall 'wrapt'. It is a distutils installed project and thus we cannot accurately determine which files belong to it which would lead to only a partial uninstall.
#This is how we solved it:
#sudo pip install -U --ignore-installed wrapt

# verify the install
python -c "import tensorflow as tf;print(tf.reduce_sum(tf.random.normal([1000, 1000])))"

deactivate # Don't deactivate until after you're done with tensorflow

## notes for myself for later
#this is the correct wheel if needed:?
#https://storage.googleapis.com/tensorflow/raspberrypi/tensorflow-1.14.0-cp34-none-linux_armv7l.whl


# Run next script:
# Install opencv
#sudo sh 03-opencvscript.sh

###################################################################################################
###################################################################################################

#######
# 01opt-dockerscript.py
#######

#----- between these lines non-working. rm later. keep only for documentation
#get and install tensorflow
#wget https://storage.googleapis.com/tensorflow/raspberrypi/tensorflow-1.14.0-cp34-none-linux_armv7l.whl
#sudo pip3 install /home/pi/tf/tensorflow-1.14.0-cp34-none-linux_armv7l.whl
# ^^ non-supported version
#----- between these lines non-working. rm later. keep only for documentation
#sudo pip3 install --upgrade https://storage.googleapis.com/tensorflow/linux/cpu/tensorflow-1.8.0-cp34-cp34m-linux_x86_64.whl
#sudo pip3 install tensorflow-1.8.0-cp34-none-linux_armv7l.whl

#wget https://github.com/lhelontra/tensorflow-on-arm/releases/download/v1.8.0/tensorflow-1.8.0-cp34-none-linux_armv7l.whl
#sudo pip3 install /home/pi/tf/tensorflow-1.8.0-cp34-none-linux_armv7l.whl
##TODO:remove double quote thingys before posting install script
#-------- end of non-working code


# update and upgrade with apt-get before doing anything
printf "\nUpdating and upgrading with apt-get\n"
sudo apt-get -y update
sudo apt-get -y upgrade
#sudo apt-get -y dist-upgrade

# Following tensorflow site suggestions:
# Install docker before tensorflow

# Following Docker site recommendationd for Debian/Raspbian:
# Instructions source:
# https://docs.docker.com/install/linux/docker-ce/debian/

# Uninstall old versions first --it's ok if none are found
printf "\nUninstalling old Docker Engine versions\n"
sudo apt-get remove docker docker-engine docker.io containerd runc

# Install docker using the convenience script:
# WARNING: Always examine scripts downloaded from the internet before running them locally!

# This example uses the script at https://test.docker.com to install the latest
# testing version of Docker Engine - Community on Linux.
# To install the latest release, use get.docker.com instead:
# In each of the commands below, replace each occurrence of test with get.

printf "\nInstalling latest testing version of Docker Engine\n"
curl -fsSL https://test.docker.com -o test-docker.sh
sudo sh test-docker.sh

# If you would like to use Docker as a non-root user, you should now consider
# adding your user to the "docker" group with something like:
#    sudo usermod -aG docker your-user
# As the pi user:
printf "\nGiving 'pi' user root permissions for Docker\n"
sudo usermod -aG docker pi

# Remember that you will have to log out and back in for this to take effect!
# WARNING: Adding a user to the "docker" group will grant the ability to run
#         containers which can be used to obtain root privileges on the
#         docker host.
#         Refer to https://docs.docker.com/engine/security/security/#docker-daemon-attack-surface
#         for more information.

######## LOG OUT OR REBOOT HERE
printf "\n------- Rebooting Now -------\n"
sudo reboot

# Run next script:
# Install pre-requisites then tensorflow
#sudo sh 02-tensorflowscript.sh


###################################################################################################
###################################################################################################


#######
# 02-tensorflowscript.py
####### 

# update and upgrade with apt-get before doing anything
printf "\n"
date
printf "\nUpdating and upgrading with apt-get\n\n"
sudo apt-get -y update
sudo apt-get -y upgrade
#sudo apt-get -y dist-upgrade

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
# XXX -- Unable to locate these... 
#time sudo apt-get install -y libxslt
#time sudo apt-get install -y libjpeg
#time sudo apt-get install -y zlib
#time sudo apt-get install -y libfreetype
#time sudo apt-get install -y libwebp
#time sudo apt-get install -y openjpeg
#time sudo apt-get install -y libimagequant
#time sudo apt-get install -y libraqm
#--
#time sudo apt-get install -y 


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
#time sudo pip install --upgrade 

# networkx requires Python '>=3.5' but the running Python is 2.7.16
# XXX time sudo pip install --upgrade scikit-image
# for some reason can't do --upgrade here ?
# XXX -- time sudo pip install --upgrade pillow
# ___*** lxml requires libxml2 and libxslt... add later?
#____***time sudo pip install --upgrade lxml
# jupyter-console requires python >=3.5
##XXX--time sudo pip install --upgrade jupyter
##XXX--time sudo pip install --upgrade jupyter

printf "\n"
date
printf "\npip3 install packages: \n\n"
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


###TODO: Do I need these?
##time sudo apt-get install -y python-smbus i2c-tools wiringpi
##time sudo apt-get install -y python-smbus
##time sudo apt-get install -y i2c-tools
##time sudo apt-get install -y wiringpi
##time sudo pip3 install --upgrade adafruit-blinka

# remove unnecessary packages
##time sudo apt autoremove

printf "\n Finished package updates \n\n"
date
printf "\n"

#### THE BELOW METHOD DID NOT WORK... WE USED A PIP INSTALL
#      IN A VIRTUAL ENV USING PIP INSTEAD...
#  script is found in pipscript.sh

# XXX --- Nonworking between these lines
#printf "\n Cloning Tensorflow from git repository \n\n"
#date
#printf "\n"
# Clone tensorflow from github for install using Docker container
#git clone https://github.com/tensorflow/tensorflow.git
#cd tensorflow


#https://storage.googleapis.com/tensorflow/raspberrypi/tensorflow-1.14.0-cp34-none-linux_armv7l.whl
#printf "\n Use build script to launch a Docker container for compilation installing tensorflow \n\n"
#date
#printf "\n"
#Cross-compile the TensorFlow source code to build a Python pip package with ARMv7 NEON instructions
#that works on Raspberry Pi 2 and 3 devices.
#The build script launches a Docker container for compilation. 
#Choosing Python 3 for the target package
#In order to do python 2.7, follow tensorflow site instructions
#CI_DOCKER_EXTRA_PARAMS="-e CI_BUILD_PYTHON=python3 -e CROSSTOOL_PYTHON_INCLUDE_PATH=/usr/include/python3.4" \
#    tensorflow/tools/ci_build/ci_build.sh PI-PYTHON3 \
#    tensorflow/tools/ci_build/pi/build_raspberry_pi.sh


#printf "\n Installing Tensorflow Now \n\n"
#date
#printf "\n"
# now install tensorflow wheel
#sudo pip3 install tensorflow-1.14.0-cp34-none-linux_armv7l.whl
####
# -- arm32v7 
# ---------------------------end of broken method ^^


# Run next script:
# Install opencv
#sudo sh 03-opencvscript.sh

###################################################################################################
###################################################################################################

#######
# 03-opencvscript.sh
#######

# update and upgrade with apt-get before doing anything
printf "\n"
date
printf "\nUpdating and upgrading with apt-get\n\n"
sudo apt-get -y update
sudo apt-get -y upgrade
#time sudo apt-get -y dist-upgrade
#sudo apt-get dist-upgrade
#sudo apt-get upgrade

printf "\n"
date
printf "\nInstalling Opencv dependencies: \n\n"
#install opencv, check dependencies 
#sudo apt-get install -y libjpeg-dev libtiff5-dev libjasper-dev libpng12-dev libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev qt4-dev-tools
sudo apt-get install -y libjpeg-dev
sudo apt-get install -y libtiff5-dev
sudo apt-get install -y libjasper-dev
sudo apt-get install -y libpng12-dev
sudo apt-get install -y libavcodec-dev
sudo apt-get install -y libavformat-dev
sudo apt-get install -y libswscale-dev
sudo apt-get install -y libv4l-dev
sudo apt-get install -y libxvidcore-dev
sudo apt-get install -y libx264-dev
sudo apt-get install -y qt4-dev-tools

printf "\n"
date
printf "\nInstalling Opencv: \n\n"
sudo apt-get install -y python3-opencv
# XXX __ below method is only backup if prev method doesn't install
#sudo pip3 install opencv-python

# Run next script:
# Install protobuf
#sudo sh 04-protobufscript.sh

###################################################################################################
###################################################################################################

#######
# 04-protobufscript.sh
#######

printf "\n"
date
printf "\nInstalling Protobuf Dependencies: \n\n"
#protobuf
sudo apt-get install -y autoconf automake libtool curl make g++ unzip

printf "\n"
date
printf "\nDownloading Protobuf \n\n"
wget https://github.com/google/protobuf/releases/download/v3.6.1/protobuf-all-3.6.1.tar.gz

# --going with 3.6.1 version instead of 3.9 because of support
#wget https://github.com/google/protobuf/releases/download/v3.9.1/protobuf-all-3.9.1.tar.gz

printf "\n"
date
printf "\nUnzipping protobuf file: \n\n"
tar -zxvf protobuf-all-3.6.1.tar.gz
cd protobuf-3.6.1

printf "\n"
date
printf "\nConfiguring protobuf: \n\n"
./configure

printf "\n"
date
printf "\n"
printf "\nRunning make: \n\n"
make

#### GRAAARG WHY IS MAKE BREAKING??!?!?! :/
##TODO: Find out what is goin on here

#####-------- CURRENT SPOT OF EXECUTION

#printf "\n"
#date
#printf "\nRunning make check: \n\n"
#make check

#printf "\n"
#date
#printf "\nRunning make install: \n\n"
#sudo make install

#printf "\n"
#date
#printf "\n cd python \n\n"
#cd python

#printf "\n"
#date
#printf "\n export LD_LIBRARY_PATH=../src/.libs  \n\n"
#export LD_LIBRARY_PATH=../src/.libs

#printf "\n"
#date
#printf "\nRunning python3 setup.py build --cpp_implementation: \n\n"
#python3 setup.py build --cpp_implementation

#printf "\n"
#date
#printf "\nRunning python3 setup.py test --cpp_implementation: \n\n"
#python3 setup.py test --cpp_implementation

#printf "\n"
#date
#printf "\nRunning python3 setup.py install --cpp_implementation: \n\n"
#sudo python3 setup.py install --cpp_implementation

#printf "\n"
#date
#printf "\nexport PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=cpp \n\n"
#export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=cpp
#printf "\nexport PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION_VERSION=3 \n\n"
#export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION_VERSION=3

#printf "\n"
#date
#printf "\nRunning sudo ldconfig: \n\n"
#sudo ldconfig

#printf "\n"
#date
#printf "\nRunning protoc: \n\n"
#protoc

#printf "\n"
#date
#printf "\nReboot Now\n\n"
#sudo reboot now




