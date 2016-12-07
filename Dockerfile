FROM ubuntu:14.04
MAINTAINER Wen-Heng (Jack) Chung <whchung@gmail.com>

# Update apt cache
RUN sudo apt-get update && sudo apt-get -y install git

# Install g++-multilib
RUN sudo apt-get -y install g++-multilib

# Install prerequisites for HIPBLAS from binary
RUN sudo apt-get -y install libblas-dev

# Install prerequisites for HICAFFE from binary
RUN sudo apt-get -y install libprotobuf-dev libleveldb-dev libsnappy-dev libopencv-dev libhdf5-serial-dev protobuf-compiler libatlas-base-dev libblas-dev libgflags-dev libgoogle-glog-dev liblmdb-dev libboost-all-dev

# Install ROCm-Device-Libs
RUN sudo curl -LO https://github.com/RadeonOpenCompute/hcc/releases/download/roc-1.4.0-rc3/rocm-device-libs-0.0.1401-Linux.deb && sudo dpkg -i rocm-device-libs-0.0.1401-Linux.deb

# Install prerequisites for HCC from binary
RUN sudo apt-get -y install libc++1 libc++-dev libc++abi1 libc++abi-dev elfutils

# Install HCC
RUN sudo curl -LO https://github.com/RadeonOpenCompute/hcc/releases/download/roc-1.4.0-rc3/hcc_lc-1.0.16490-Linux.deb && sudo dpkg -i hcc_lc-1.0.16490-Linux.deb

# Install prerequisites for OpenCL from binary
RUN sudo apt-get -y install unzip

# Download OpenCL
RUN sudo curl -LO https://github.com/RadeonOpenCompute/hcc/releases/download/roc-1.4.0-rc3/OpenCL_Linux_x86_64_Release_1346668_artifacts.zip

# Download HIP from source
RUN git clone -b sonoma-v1 https://github.com/whchung/HIP.git 

# Build HIPBLAS from source and install it
RUN git clone -b sonoma-v1 https://bitbucket.org/multicoreware/hcblas.git 

# Build HIPRNG from source and install it
RUN git clone -b sonoma-v1 https://github.com/whchung/hcrng.git

# Build HIP
# RUN cd ~/HIP && mkdir build && cd build \
#    && cmake .. \
#    && make -j$(nproc) \
#    && sudo make install

# Build HIPBLAS
# RUN cd ~/hcblas && sh ./build.sh \
#    && sudo dpkg -i build/hcblas-master-*.deb

# Build HIPRNG
# RUN cd ~/hcblas && sh ./build.sh \
#    && sudo dpkg -i build/hcblas-master-*.deb

# Build MIOpen from source and install it
#RUN git clone -b sonoma-v1 https://github.com/AMDComputeLibraries/MLOpen.git \
#    && cd ~/MLOpen && mkdir build && cd build \
#    && cmake -DMLOPEN_BACKEND=HIP .. \
#    && make -j$(nproc) \
#    && sudo make install

# Build HIPCAFFE from source
#RUN git clone -b sonoma3 https://bitbucket.org/multicoreware/hipcaffe.git \
#    && sudo ln /dev/null /dev/raw1394 \
#    && cd ~/hipcaffe \
#    && make -j$(nproc)

# Get CIFAR10
#RUN cd ~/hipcaffe && ./data/cifar10/get_cifar10.sh && ./examples/cifar10/create_cifar10.sh

# Extract OpenCL
#RUN unzip OpenCL_Linux_x86_64_Release_1346668_artifacts.zip

# Setup environment variables
#RUN export AOC_PATH=~/opencl/bin/x86_64/aoc2 && export LD_LIBRARY_PATH=~/opencl/lib/x86_64

# Run CIFAR10
# cd ~/hipcaffe && build/tools/caffe train --solver=examples/cifar10/cifar10_quick_solver.prototxt

# Run convent benchmark
# git clone https://github.com/soumith/convnet-benchmarks.git \
# && cd hipcaffe && build/tools/caffe time --model=../convnet-benchmarks/caffe/imagenet_winners/alexnet.prototxt --iterations 2  --gpu 0

