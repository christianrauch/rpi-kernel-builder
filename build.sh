KERNEL=kernel_2712
make bcm2712_defconfig

scripts/kconfig/merge_config.sh .config my.fragment
