# GPU compatible docker container
FROM nvidia/opengl:1.0-glvnd-devel-ubuntu20.04
# setting noninteractive flag
# this forbids apt to throw questions 
ARG DEBIAN_FRONTEND=noninteractive

ENV NVIDIA_DRIVER_CAPABILITIES=${NVIDIA_DRIVER_CAPABILITIES},display,compute,utility
RUN apt-get update && apt-get install -y --no-install-recommends \
 mesa-utils && \
 rm -rf /var/lib/apt/lists/*


### Installing ROS Noetic
RUN apt update --fix-missing
RUN apt install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa
RUN apt install -y curl
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
RUN apt update
RUN apt install -y ros-noetic-desktop-full
RUN apt install -y python3-rosdep python3-rosinstall python3-rosinstall-generator python3-wstool build-essential
RUN apt install -y python3-rosdep
RUN rosdep init
RUN rosdep update
SHELL ["/bin/bash", "-c"]
RUN apt install -y wget vim
# Install cuda drivers
# RUN wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-keyring_1.1-1_all.deb
# RUN dpkg -i cuda-keyring_1.1-1_all.deb
# RUN apt-get -y update
# RUN apt-get -y install cuda-toolkit-12-4
# ENV CUDA_HOME="/usr/local/cuda-12.4"
# ENV LD_LIBRARY_PATH=${CUDA_HOME}/lib64:$LD_LIBRARY_PATH
# ENV PATH="$PATH:$CUDA_HOME/bin"
# RUN apt-get install -y python3-catkin-tools feh
WORKDIR /app/ssrr_ws/src
RUN apt-get install -y python3-catkin-tools feh
RUN wget https://packages.clearpathrobotics.com/public.key -O - | sudo apt-key add -
RUN sh -c 'echo "deb https://packages.clearpathrobotics.com/stable/ubuntu $(lsb_release -cs) main" > /etc/apt/sources.list.d/clearpath-latest.list'
RUN apt update
RUN apt install -y ros-noetic-warthog-desktop
# ROS IP ADDRESS
ENV ROS_IP=192.168.1.10
ENV ROS_MASTER_URI=http://192.168.1.102:11311
WORKDIR /app/ssrr_ws