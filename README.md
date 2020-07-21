# VMSetup
This is a simple shell script which will install the following tools
1. `CUDA 10.1`
3. `CuDNN 7.6.4.38`
4. `Pytorch`
5. Nvidia Driver 450
6. `Python 3`
    1. `tensorflow-gpu`
    2. `PyTorch`
    3. `keras`
    4. `jupyter`
    5. `numpy`
    6. `pandas`
    7. `networkx`
    8. `scikit-learn`

To run this, simply clone this repository then execute

```shell
cd VMSetup
./new-vm.sh
```

This will then execute all the installation scripts. Note that this will take some time depending on your internet connection, and will use > 8 Gb of disk. 

**NOTE**: This does reboot (and automatically resume installation) your VM, so you will lose connection. 
