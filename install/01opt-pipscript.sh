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

# Instructions source: # https://www.tensorflow.org/install/pip

# 1. Install Python Development System:
#install python > 3.4
# put command to install python here

# install pip3
# put version in here with command for install > X.X

#install virtualenv
sudo pip3 install virtualenv

# check your versions:
python3 --version
pip3 --version
virtualenv --version

# for Raspian system:
sudo apt update
sudo apt install -y python3-dev python3-pip
sudo apt install -y libatlas-base-dev 
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

# check your versions
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

# Run next script: 
# Install opencv
#sudo sh 03-opencvscript.sh

