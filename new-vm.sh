#!/bin/bash

# This is a quick bash script that simply automates 
# the installation process of a lot of packages I use 
# on VMs and usually screw up when I install manually

# As this involves rebooting our system, we must first check
# if we have run this script before or not

if [ ! -f /var/run/resume-after-boot ]; then
    # Purge anything pre-installed 
    # echo "Purging ... "
    # sudo apt-get --purge remove "*cublas*" "cuda*" -s -y
    # sudo apt-get --purge remove "libcudnn7*" -s -y
    # sudo apt-get --purge remove "*nvidia*" -s -y

    echo "First step instalation of packages...."
    # adding tensorflow/cuda libraries 
    wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/cuda-repo-ubuntu1804_10.1.243-1_amd64.deb
    sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/7fa2af80.pub
    sudo dpkg -i cuda-repo-ubuntu1804_10.1.243-1_amd64.deb
    sudo apt-get update
    wget http://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb
    sudo apt install ./nvidia-machine-learning-repo-ubuntu1804_1.0.0-1_amd64.deb 
    sudo apt-get update
    # python
    echo "Python installation...."
    sudo apt-get install python3  -y
    sudo apt-get install python3-pip -y
    # cuda
    echo "Cuda Drivers...." 
    sudo apt-get install --no-install-recommends nvidia-driver-450 -y 

    script="bash /home/ubuntu/VMSetup/new-vm.sh"
    echo "$script" >> ~/.bashrc 
    # sudo touch /var/run/resume-after-boot
    sudo touch /var/run/resume-after-boot

    if [ -f /var/run/resume-after-boot ]; then
        echo "rebooting"
        # sudo reboot
        echo "I WOULD HAVE REBOOTED HERE"
    else
        echo "Resume File Does Not Exist!"
        exit 1
    fi

else
    echo "Resuming installation..."
    sed -i '/bash/d' ~/.bashrc
    # get rid of the file so we don't consistently keep rebooting 
    sudo rm -f /var/run/resume-after-boot
    touch /home/ubuntu/made_it.txt
    # test if nvidia-smi works
    if [ $? -eq 0 ]; then
        echo "Nvidia works!"
    else 
        echo "Nvidia failed"
        exit 1
    fi

    # # Start installing CUDA and tensorflow
    # echo "Installing CUDA and CuDNN"
    sudo apt-get install --no-install-recommends cuda-10-1 
    sudo apt-get install --no-install-recommends libcudnn7=7.6.4.38-1+cuda10.1  
    sudo apt-get install --no-install-recommends libcudnn7-dev=7.6.4.38-1+cuda10.1 
    sudo apt-get install -y --no-install-recommends libnvinfer6=6.0.1-1+cuda10.1 
    sudo apt-get install -y --no-install-recommendslibnvinfer-dev=6.0.1-1+cuda10.1 
    sudo apt-get install -y --no-install-recommendslibnvinfer-plugin6=6.0.1-1+cuda10.1 

    echo "Installing Python Packages"
    pip3 install numpy pandas jupyter scikit-learn networkx 
    echo "Installing tensorflow"
    pip3 install tensorflow-gpu
    echo "Installing pytorch"
    pip3 install torch==1.5.1+cu101 torchvision==0.6.1+cu101 -f https://download.pytorch.org/whl/torch_stable.html
    echo "Installing keras"
    pip3 install keras

fi


