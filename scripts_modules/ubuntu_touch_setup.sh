#!/bin/bash

# Add the 32bits architecture to the container system
dpkg --add-architecture i386

# Update your package lists to take advantage of the new architecture:
apt update && apt upgrade -y

# Install curl:
apt install -y curl

# Create a directory named ‘bin’ in your home directory, and include it in your path:
mkdir -p ~/bin
echo export PATH=\$PATH:\$HOME/bin >> ~/.bashrc
source ~/.bashrc

# Download the repo script and make it executable:
curl https://storage.googleapis.com/git-repo-downloads/repo > ~/bin/repo
chmod a+rx ~/bin/repo