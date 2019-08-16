#!/bin/bash

# Copyright © 2019 Chris McPherson
# chris@techfocus.net
# [This program is licensed under the "MIT License"]
# Please see the file LICENSE in the source
# distribution of this software for license terms.

# installing all the prerequisites for protobuf
sudo apt-get install autoconf automake libtool curl

#download and extract protobuf files
wget https://github.com/google/protobuf/releases/download/v3.5.1/protobuf-all-3.5.1.tar.gz

tar -zxvf protobuf-all-3.5.1.tar.gz
cd protobuf-3.5.1

# this step will take a bit
./configure

# this takes a lot longer
make
make check 
sudo make install
cd python
export LD_LIBRARY_PATH=../src/.libs

#note the use of python rather than python3, python 3.7 breaks on installation
python setup.py build --cpp_implementation 
python setup.py test --cpp_implementation
sudo python setup.py install --cpp_implementation

#add it to environment
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION=cpp
export PROTOCOL_BUFFERS_PYTHON_IMPLEMENTATION_VERSION=3

sudo ldconfig

#displays that protocol buffers works
protoc

