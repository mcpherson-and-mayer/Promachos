#!/bin/bash

# Copyright © 2019 Sharice Mayer
# mayers.research@gmail.com
# [This program is licensed under the "MIT License"]
# Please see the file LICENSE in the source
# distribution of this software for license terms.

# update and upgrade with apt-get before doing anything
printf "\n"
date
printf "\nUpdating and upgrading with apt-get\n\n"
sudo apt-get -y update
sudo apt-get -y upgrade
#time sudo apt-get -y dist-upgrade

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

# Run next script:
# Install protobuf
#sudo sh 04-protobufscript.sh


