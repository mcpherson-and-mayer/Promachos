#!/bin/bash

# Copyright © 2019 Sharice Mayer
# mayers.research@gmail.com
# [This program is licensed under the "MIT License"]
# Please see the file LICENSE in the source
# distribution of this software for license terms.

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


# Run next script to prepare for tensorflow install:
# TWO OPTIONS:

# 1. Build tensorflow from source
# https://www.tensorflow.org/install/source_rpi
# Install Docker:
#sudo sh 01opt-dockerscript.sh
# Then install tensorflow with container:
#sudo sh 02-tensorflowscript.sh

# 2. Install tensorflow with pip
# https://www.tensorflow.org/install/pip
# **THIS IS MY RECOMMENDED APPROACH
#sudo sh 01opt-pipscript.sh

