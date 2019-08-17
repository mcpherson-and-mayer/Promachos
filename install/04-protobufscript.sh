#!/bin/bash

# Copyright © 2019 Sharice Mayer and Chris Pherson
# mayers.research@gmail.com
# chris@techfocus.net
# [This program is licensed under the "MIT License"]
# Please see the file LICENSE in the source
# distribution of this software for license terms.

# update and upgrade with apt-get before doing anything
printf "\nUpdating and upgrading with apt-get\n"
sudo apt-get -y update
sudo apt-get -y upgrade
#sudo apt-get -y dist-upgrade

printf "\n"
date
printf "\nInstalling Protobuf Dependencies: \n\n"
#protobuf
sudo apt-get install -y autoconf automake libtool curl make g++ unzip

printf "\n"
date
printf "\nDownloading Protobuf \n\n"
# --going with 3.5.1 version instead of 3.9 because of support
wget https://github.com/google/protobuf/releases/download/v3.5.1/protobuf-all-3.5.1.tar.gz

printf "\n"
date
printf "\nUnzipping protobuf file: \n\n"
tar -zxvf protobuf-all-3.5.1.tar.gz
cd protobuf-3.5.1

printf "\n"
date
printf "\nConfiguring protobuf: \n"
printf "\nThis Step May Take Awhile... \n\n"
./configure

printf "\n"
date
printf "\nRunning make: \n"
printf "\nThis Step May Take Even Longer... \n\n"
make

printf "\n"
date
printf "\nRunning make check: \n\n"
printf "\nThis Step Will Take Even Longer... \n\n"
make check

printf "\n"
date
printf "\nRunning make install: \n\n"
sudo make install

printf "\n"
date
printf "\n cd python \n\n"
cd python

printf "\n"
date
printf "\n export LD_LIBRARY_PATH=../src/.libs  \n\n"
export LD_LIBRARY_PATH=../src/.libs

printf "\n"
date
printf "\nRunning python3 setup.py build --cpp_implementation: \n\n"
python3 setup.py build --cpp_implementation

printf "\n"
date
printf "\nRunning python3 setup.py test --cpp_implementation: \n\n"
python3 setup.py test --cpp_implementation

printf "\n"
date
printf "\nRunning python3 setup.py install --cpp_implementation: \n\n"
sudo python3 setup.py install --cpp_implementation

printf "\n"
date
printf "\nModify Environment:\n"
printf "\nexport PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=cpp \n"
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=cpp
printf "\nexport PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION_VERSION=3 \n"
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION_VERSION=3

printf "\n"
date
printf "\nRunning sudo ldconfig: \n\n"
sudo ldconfig

printf "\n"
date
printf "\nRunning protoc to check that protocol buffer works: \n\n"
protoc

printf "\n"
date
printf "\n"
printf "\nReboot Now\n\n"
sudo reboot now




