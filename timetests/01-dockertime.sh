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

# Following tensorflow site suggestions:
# Install docker before tensorflow

# Following Docker site recommendationd for Debian/Raspbian:
# Instructions source:
# https://docs.docker.com/install/linux/docker-ce/debian/

# Uninstall old versions first --it's ok if none are found
printf "\nUninstalling old Docker Engine versions\n"
time sudo apt-get remove docker docker-engine docker.io containerd runc

# Install docker using the convenience script:
# WARNING: Always examine scripts downloaded from the internet before running them locally!

# This example uses the script at https://test.docker.com to install the latest 
# testing version of Docker Engine - Community on Linux. 
# To install the latest release, use get.docker.com instead:  
# In each of the commands below, replace each occurrence of test with get.

printf "\nInstalling latest testing version of Docker Engine\n"
time curl -fsSL https://test.docker.com -o test-docker.sh
time sudo sh test-docker.sh

# If you would like to use Docker as a non-root user, you should now consider
# adding your user to the "docker" group with something like:
#    sudo usermod -aG docker your-user
# As the pi user: 
printf "\nGiving 'pi' user root permissions for Docker\n"
time sudo usermod -aG docker pi

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
# Install pre-requisites for tensorflow
#sudo ./02-pretensorflowscript.sh


