#!/bin/bash
#Created by Shim'on Sukholuski
#After Installing CUDA Toolkit and GCC 7 and G++ 7
#Download from https://developer.nvidia.com/rdp/cudnn-archive
#Under Download cuDNN v7.6.5 (November 5th, 2019), for CUDA 10.1
#cuDNN Runtime Library for Ubuntu18.04 (Deb)
#cuDNN Developer Library for Ubuntu18.04 (Deb)
#cuDNN Code Samples and User Guide for Ubuntu18.04 (Deb)
#If there are premission problems "chown -R $USER" the directory to modify or "chmod -R 777"
#Run in the download location!
gccV=$(gcc -dumpversion)
gppV=$(gpp -dumpversion)
sudo update-alternatives --set gcc /usr/bin/gcc-7
sudo update-alternatives --set g++ /usr/bin/g++-7
sudo dpkg -i libcudnn8_7.6.5-1+cuda10.1_amd64.deb
sudo dpkg -i libcudnn8-dev_8.7.6.5--1+cuda10.1_amd64.deb
sudo dpkg -i libcudnn8-samples_8.7.6.5--1+cuda10.1_amd64.deb
#Check Installations
cp -r /usr/src/cudnn_samples_v8/ $HOME
cd  $HOME/cudnn_samples_v8/mnistCUDNN
make clean && make
./mnistCUDNN	#Will say the test is passed if everything works
sudo update-alternatives --set gcc /usr/bin/gcc-$gccV
sudo update-alternatives --set g++ /usr/bin/g++-$gppV
