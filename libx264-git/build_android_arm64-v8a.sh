#!/bin/bash

TOOLCHAIN=$TOOLCHAIN_ARM64
HOST=aarch64-linux
CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-

SYSROOT=$TOOLCHAIN/sysroot
PLATFORM=$TOOLCHAIN/platforms/android-21/arch-arm64/
PREFIX=$PREFIX_PATH/arm64

function build_one
{
make clean
./configure \
  --prefix=$PREFIX \
  --enable-static \
  --enable-shared \
  --enable-pic \
  --host=$HOST \
  --cross-prefix=$CROSS_PREFIX \
  --sysroot=$SYSROOT

  make -j$(nproc) install || exit 1
}

build_one

echo Android ARM64 builds finished
