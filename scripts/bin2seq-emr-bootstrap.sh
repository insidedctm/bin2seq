#!/bin/bash

cd /home/hadoop
echo "" >>~/.bashrc
echo "export LD_LIBRARY_PATH=/usr/lib64/jhdf5:$LD_LIBRARY_PATH" >> ~/.bashrc
echo "export AWS_ACCESS_KEY=" >>~/.bashrc
echo "export AWS_SECRET_KEY=" >>~/.bashrc

#install OpenCV dependency gtk2
sudo wget --no-check-certificate https://raw.githubusercontent.com/dayne/yum/master/centos6/CentOS-Base.repo -O /etc/yum.repos.d/CentOS-Base.repo
sudo sed -i 's/$releasever/6/g' /etc/yum.repos.d/CentOS-Base.repo
sudo yum -y install gtk2 libv4l

#enable 'Extra Packages' and EPEL
cat /etc/yum.repos.d/epel.repo |sed 's/enabled=0/enabled=1/g' > tmp 
sudo cp tmp /etc/yum.repos.d/epel.repo
sudo yum install -y opencv-python gdal gdal-devel hdf5 hdf5-devel git 
sudo wget http://repos.fedorapeople.org/repos/dchen/apache-maven/epel-apache-maven.repo -O /etc/yum.repos.d/epel-apache-maven.repo
sudo sed -i 's/$releasever/6/g' /etc/yum.repos.d/epel-apache-maven.repo
sudo yum -y install apache-maven 

sudo yum -y install python-pip python-devel netcdf4-python numpy

git clone https://github.com/openreserach/bin2seq.git
cd bin2seq
mvn clean compile

#only at master node
#sudo pip install aws 

