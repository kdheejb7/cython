FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu16.04 

MAINTAINER 0.1 dhkim@casys.kaist.ac.kr

RUN apt-get update  
RUN apt-get install -y build-essential wget python3 python3-pip python3-dev git libssl-dev \
					   vim tmux wget autoconf automake libtool curl make g++ unzip language-pack-en \
					   ffmpeg libsm6 libxrender-dev libopenblas-dev

RUN python3 -m pip install --upgrade pip
RUN python3 -m pip install setuptools numpy==1.16.4 opencv-python cython tensorflow==1.15.2 networkx
RUN python3 -m pip uninstall -y setuptools
RUN python3 -m pip install setuptools


