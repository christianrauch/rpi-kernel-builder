# syntax=docker/dockerfile:1

ARG UBUNTU_VERSION=26.04
FROM ubuntu:${UBUNTU_VERSION}

ENV DEBIAN_FRONTEND=noninteractive

# RUN apt update \
#     && apt install -y --no-install-recommends \
#         bc \
#         bison \
#         build-essential \
#         ca-certificates \
#         cpio \
#         device-tree-compiler \
#         dwarves \
#         file \
#         flex \
#         gcc-aarch64-linux-gnu \
#         gcc-arm-linux-gnueabihf \
#         git \
#         kmod \
#         libelf-dev \
#         libncurses-dev \
#         libssl-dev \
#         make \
#         pahole \
#         perl \
#         python3 \
#         rsync \
#         xz-utils \
#         zstd \
#     && rm -rf /var/lib/apt/lists/*

# https://www.raspberrypi.com/documentation/computers/linux_kernel.html

RUN apt update \
    && apt install -y --no-install-recommends \
        bc bison flex libssl-dev make gcc \
        build-essential \
        debhelper-compat kmod libdw-dev:native libelf-dev:native python3:native rsync \
        lsb-release \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /workspace

CMD ["/bin/bash"]
