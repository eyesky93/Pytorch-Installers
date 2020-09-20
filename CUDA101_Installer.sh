#!/bin/bash
#Created by Shim'on Sukholuski
#Uninstall existing versions!
#Uncomment rm -rf at the end to remove installation files
#Making sure gcc and g+ installed, at the end return to the original
#If there are premission problems "chown -R $USER" the directory to modify or "chmod -R 777"
#Useful link https://gist.github.com/QCaudron/dfc20d7010f9b0d200d5c28dc46bf085
gccV=$(gcc -dumpversion)
gppV=$(g++ -dumpversion)
if [ $gccV -ne 7 ] || [ $gppV -ne 7 ]
then
	sudo apt update
	sudo apt upgrade
	sudo apt -y install gcc-7 g++-7 gcc-8 g++-8 gcc-9 g++-9
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-7 7
	sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-7 7
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 8
	sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-8 8
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-9 9
	sudo update-alternatives --install /usr/bin/g++ g++ /usr/bin/g++-9 9
	sudo update-alternatives --set gcc /usr/bin/gcc-7
	sudo update-alternatives --set g++ /usr/bin/g++-7
fi
#Installing CUDA toolkit 10.1
sudo apt-get install freeglut3-dev build-essential libx11-dev libxmu-dev libxi-dev libglu1-mesa libglu1-mesa-dev
sudo apt-get install linux-headers-$(uname -r)
wget https://developer.nvidia.com/compute/cuda/10.1/Prod/local_installers/cuda-repo-ubuntu1810-10-1-local-10.1.105-418.39_1.0-1_amd64.deb -O ~/Downloads/cuda-repo-ubuntu1810-10-1-local-10.1.105-418.39_1.0-1_amd64.deb
sudo apt-key add ~/Downloads/var/cuda-repo-<version>/7fa2af80.pub
sudo apt-get update
sudo apt-get install cuda
export PATH="/usr/local/cuda-10.1/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-10.1/lib64:$LD_LIBRARY_PATH"
echo 'export PATH="/usr/local/cuda-10.1/bin:$PATH"' >> /home/$USER/.bashrc
echo 'export LD_LIBRARY_PATH="/usr/local/cuda-10.1/lib64:$LD_LIBRARY_PATH"' >> /home/$USER/.bashrc
#Confirming Installation
cuda-install-samples-10.1.sh <dir>
cat /proc/driver/nvidia/version #Check if the driver version is correct
cd ~/NVIDIA_CUDA-10.1_Samples
make
1_Utilities/deviceQuery #Will say the test is passed if everything works
#rm -rf ~/Downloads/cuda-repo-ubuntu1810-10-1-local-10.1.105-418.39_1.0-1_amd64.deb
sudo update-alternatives --set gcc /usr/bin/gcc-$gccV
sudo update-alternatives --set g++ /usr/bin/g++-$gppV
