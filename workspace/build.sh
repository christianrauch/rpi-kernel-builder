#!/usr/bin/env bash

cd linux

# generate default config
KERNEL=kernel_2712
make bcm2712_defconfig

# # patch config with RT settings
# ./scripts/kconfig/merge_config.sh -m .config ../config/rt.config
# make olddefconfig

# build
make -j"$(nproc)" Image.gz modules dtbs bindeb-pkg
