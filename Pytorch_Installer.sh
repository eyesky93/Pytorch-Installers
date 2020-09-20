#!/bin/bash
#Created by Shim'on Sukholuski
#Run in the project folder
#Uncomment rm -rf at the end to remove installation files
#If there are premission problems "chown -R $USER" the directory to modify or "chmod -R 777"
#If you're using Pycharm install throught it's terminal. It needs to have the same premissions to
#add a package, and installing through it will make sure of that.
#Making sure gcc and g+ installed, at the end return to the original
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
#Use after installing the appropriate CUDA toolkit and Cudnn
Cuda_CC=3.0	#Your GPU's cuda compute capability
Python_Version=1.6.0
#Clearing Conflicting Packages
conda remove -y --force-remove magma-cuda
conda remove -y --force-remove cudatoolkit
conda remove -y --force-remove torch
conda remove -y --force-remove torchvision
conda remove -y --force-remove numpy ninja pyyaml mkl mkl-include setuptools cmake cffi typing_extensions future six requests dataclasses
#Installing Packages
conda install -y numpy ninja pyyaml mkl mkl-include setuptools cmake cffi typing_extensions future six requests dataclasses
conda install -y -c pytorch magma-cuda101	#Replace with a different version if needed
#Installing Pytorch
git clone --recursive https://github.com/pytorch/pytorch
cd pytorch
export CMAKE_PREFIX_PATH=${CONDA_PREFIX:-"$(dirname $(which conda))/../"}
export CUDA_ARCH_LIST="$Cuda_CC"
export PYTORCH_BUILD_VERSION=$Python_Version
export PYTORCH_BUILD_NUMBER=1
export CUDA_HOME=/usr/local/cuda
export CUDNN_LIB_DIR=/usr/local/cuda
#If you want Totchvision to work
Original="supported_arches = \["
New="supported_arches = \[\'$Cuda_CC\', "
sed -i "s:$Original:$New:" torch/utils/cpp_extension.py
python setup.py build --cmake
python setup.py install
cd ..
#rm -rf pytorch
git clone --recursive https://github.com/pytorch/vision
cd vision
python setup.py install
cd ..
#rm -rf vision
sudo update-alternatives --set gcc /usr/bin/gcc-$gccV
sudo update-alternatives --set g++ /usr/bin/g++-$gppV
