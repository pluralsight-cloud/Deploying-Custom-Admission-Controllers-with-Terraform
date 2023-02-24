#!/usr/bin/env bash

### Installing Homebrew ###
echo "Installing Homebrew"
#yum -y install git docker
sudo yum -y install git docker
#usermod -a -G docker cloud_user
sudo usermod -a -G docker cloud_user
#su - cloud_user -c 'newgrp docker'
newgrp docker
#systemctl enable docker.service
sudo systemctl enable docker.service
#systemctl start docker.service
sudo systemctl start docker.service

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

### Adding Homebrew to your PATH ###
echo "Adding Homebrew to your PATH"
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
brew install wget jq unzip gcc awscli terraform