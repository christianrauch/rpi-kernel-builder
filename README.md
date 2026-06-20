# Raspberry Pi Kernel Builder

```bash
docker build -t rpi-kernel-builder .
```

```bash
cd ./workspace/
git clone --depth=1 --branch rpi-6.18.y https://github.com/raspberrypi/linux.git
```

```bash
docker run --rm \
  -v "$PWD/workspace/:/workspace/"\
  rpi-kernel-builder ./workspace/build.sh
```


```bash
docker run --rm -it \
  -v "$PWD/linux:/workspace" \
  rpi-kernel-builder
```

```bash
docker run --rm -it \
  -v "$PWD/:/workspace" \
  rpi-kernel-builder
```


inside docker:

```bash
cd linux
KERNEL=kernel_2712
make bcm2712_defconfig

./scripts/kconfig/merge_config.sh -m .config ../rt.config
make olddefconfig
```



```bash
make -j"$(nproc)" Image.gz modules dtbs
```


```bash
# generate default ".config"
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2712_defconfig
# edit the ".config"
```


```bash
make -j2 Image.gz modules dtbs
```





Check that the expected cross-compilers are available:

```bash
docker run --rm rpi-kernel-builder sh -lc \
  'aarch64-linux-gnu-gcc --version && arm-linux-gnueabihf-gcc --version'
```

## Get the Raspberry Pi Kernel Source

Clone the Raspberry Pi kernel source next to this repository, or into any local
directory you want to mount into the container:

```bash
git clone --depth=1 https://github.com/raspberrypi/linux.git
```

If you need a specific Raspberry Pi kernel branch, pass `--branch`:

```bash
git clone --depth=1 --branch rpi-7.1.y https://github.com/raspberrypi/linux.git
```

## Start the Build Container

Mount the kernel source into `/work`:



All commands below are run inside the container from `/work`.

## Build a 64-bit Kernel

Use this for Raspberry Pi OS 64-bit.

For Raspberry Pi 5:

cd linux
KERNEL=kernel_2712
make bcm2712_defconfig

```bash
# KERNEL=kernel_2712
# ARCH=arm64
# CROSS_COMPILE=aarch64-linux-gnu-
# make bcm2712_defconfig

# make -j6 Image.gz modules dtbs

make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- bcm2712_defconfig

make -j"$(nproc)" ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- Image.gz modules dtbs
```



## Install Build Artifacts into a Staging Directory

Create a local output directory from inside the container:

```bash
mkdir -p /workspace/out
```

Install modules into the staging directory:

```bash
make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu- \
  INSTALL_MOD_PATH=/work/out modules_install
```

For a 32-bit build, use:

```bash
make ARCH=arm CROSS_COMPILE=arm-linux-gnueabihf- \
  INSTALL_MOD_PATH=/work/out modules_install
```

Kernel images and device trees remain in the kernel tree after the build:

```text
arch/arm64/boot/Image
arch/arm/boot/zImage
arch/arm64/boot/dts/broadcom/*.dtb
arch/arm/boot/dts/broadcom/*.dtb
```

## Clean the Kernel Tree

Remove generated build output:

```bash
make mrproper
```

Run the defconfig command again before starting another build.
