#!/usr/bin/env bash

### Installing Homebrew ###
echo "Installing Homebrew"

### Install Docker ###
yum -y install docker
usermod -a -G docker cloud_user
su - cloud_user -c 'newgrp docker'
systemctl enable docker.service
systemctl start docker.service

sleep 3

#yum -y install git
sudo yum -y install git

sleep 3

### Installing Homebrew ###
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

### Adding Homebrew to your PATH ###
echo "Adding Homebrew to your PATH"
sleep 2
(echo; echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"') >> /home/cloud_user/.bash_profile
sleep 2
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
sleep 2

### Installing Homebrew dependencies ###
echo "Installing Homebrew dependencies"
sudo yum groupinstall 'Development Tools'

### Homebrew installation finished ###
echo "Homebrew installation finished"

### Installing lab specific packages ###
echo "Installing lab specific packages"
brew install wget jq unzip gcc awscli terraform kubectl