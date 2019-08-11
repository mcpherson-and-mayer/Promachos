#!/bin/bash

# Copyright © 2019 Sharice Mayer and Chris Pherson
# mayers.research@gmail.com
# chris@techfocus.net
# [This program is licensed under the "MIT License"]
# Please see the file LICENSE in the source
# distribution of this software for license terms.

# update and upgrade with apt-get before doing anything
printf "\nUpdating and upgrading with apt-get\n"
time sudo apt-get -y update
time sudo apt-get -y dist-upgrade
#sudo apt-get dist-upgrade
#sudo apt-get upgrade

# install vim since nano stinks
# --requires reboot!
printf "\nInstalling VIM\n"
time sudo apt-get install vim

printf "\n------- Rebooting Now -------\n"
sudo reboot now

# Run next script:
# Install Docker:
#sudo ./01-docker_script.sh


