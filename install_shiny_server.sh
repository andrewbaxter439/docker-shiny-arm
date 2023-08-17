#!/bin/bash
set -e

# Install Shiny server

git clone https://github.com/rstudio/shiny-server.git

# Get into a temporary directory in which we'll build the project
cd shiny-server
mkdir tmp
cd tmp


# Install our private copy of Node.js
/rocker_scripts/install_node.sh

# Add the bin directory to the path so we can reference node
DIR=`pwd`
PATH=$DIR/../bin:$PATH

# Use cmake to prepare the make step. Modify the "--DCMAKE_INSTALL_PREFIX"
# if you wish the install the software at a different location.
cmake -DCMAKE_INSTALL_PREFIX=/usr/local ../
# Get an error here? Check the "How do I set the cmake Python version?" question below

# Compile native code and install npm dependencies
make
mkdir ../build
echo `ls` 
(cd .. && ./bin/npm install)

# Install the software at the predefined location
sudo make install

# Install default config file
sudo mkdir -p /etc/shiny-server
sudo cp ../config/default.config /etc/shiny-server/shiny-server.conf


# Place a shortcut to the shiny-server executable in /usr/bin
sudo ln -s /usr/local/shiny-server/bin/shiny-server /usr/bin/shiny-server

# Create shiny user. On some systems, you may need to specify the full path to 'useradd'
sudo useradd -r -m shiny

# Create log, config, and application directories
sudo mkdir -p /var/log/shiny-server
sudo mkdir -p /srv/shiny-server
sudo mkdir -p /var/lib/shiny-server
sudo chown shiny /var/log/shiny-server
sudo mkdir -p /etc/shiny-server

sudo cp ../samples/* /srv/shiny-server/

