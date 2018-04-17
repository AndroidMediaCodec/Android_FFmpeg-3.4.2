#!/bin/bash

TOOLCHAIN=$TOOLCHAIN_x86_64
HOST=x86_64-linux
CROSS_PREFIX=$TOOLCHAIN/bin/x86_64-linux-android-

SYSROOT=$TOOLCHAIN/sysroot
PLATFORM=$TOOLCHAIN/platforms/android-21/arch-x86_64/
PREFIX=$PREFIX_PATH/x86_64

function build_one
{
  make clean
  ./configure \
  --prefix=$PREFIX \
  --enable-static \
  --enable-shared \
  --enable-pic \
  --disable-asm \
  --host=$HOST \
  --cross-prefix=$CROSS_PREFIX \
  --sysroot=$SYSROOT

  make -j$(nproc) install || exit 1
}

build_one

echo Android x86_64 builds finished
