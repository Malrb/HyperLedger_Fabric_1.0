#!/bin/bash 
#

echo "========Welcome to HyperLeder Fabric 1.0 Setup script========="
cd $HOME
### update
sudo apt-get -y update
sudo apt-get -y upgrade

### setup curl
sudo apt-get -y install curl

### setup pip python git
sudo apt-get -y install python-pip git

### setup nodejs & npm 3.10.10
sudo curl -sL https://deb.nodesource.com/setup_6.x -o nodesource_setup.sh
sudo bash nodesource_setup.sh
sudo apt-get install -y nodejs
sudo apt-get install -y build-essential
sudo npm install npm@3.10.10 -g
sudo rm nodesource_setup.sh
### setup go 1.8
cd $HOME
sudo wget https://storage.googleapis.com/golang/go1.8.linux-amd64.tar.gz 
sudo tar -C /usr/local -xzf go1.8.linux-amd64.tar.gz
sudo su <<EOF
echo "add instructions in /etc/profile "
echo "# This is for go language 1.8" >> /etc/profile
echo "export GOROOT=/usr/local/go" >> /etc/profile
echo "export PATH=$PATH:$GOROOT/bin" >> /etc/profile
source /etc/profile
EOF

### setup docker & test
curl -fsSL https://get.docker.com/ | sh
sudo docker run hello-world
### setup docker-compose
sudo pip install docker-compose
### gain docker auth for user 
sudo usermod -a -G docker $USER

#download fabric-samples
cd $HOME
sudo git clone https://github.com/hyperledger/fabric-samples.git
cd fabric-samples
sudo su <<HERE
curl -sSL https://goo.gl/iX9dek | bash
HERE
cd $HOME

echo "=========================Mission Complete....?!============================"
echo "Now you have to do some stuff"
echo "1. use sudo to edit /etc/default/docker by following contents:"
echo "   DOCKER_OPTS=\"$DOCKER_OPTS -H tcp://0.0.0.0:2375 -H unix:///var/run/docker.sock --api-cors-header='*'\" "
echo "2. do the following instructions for Ubuntu 16.04"
echo "   sudo systemctl daemon-reload"
echo "   sudo systemctl restart docker.service"
echo "   ======================================"
echo "   or do the following for 14.04"
echo "   sudo service docker restart"
echo "3. Logout and login , or reboot.Make sure docker is up after reboot."
echo "=========================Congraduations, env_Setup ========================="
