#!/bin/bash

TOOLCHAIN=$TOOLCHAIN_x86
HOST=i686-linux
CROSS_PREFIX=$TOOLCHAIN/bin/i686-linux-android-

SYSROOT=$TOOLCHAIN/sysroot
PLATFORM=$TOOLCHAIN/platforms/android-21/arch-x86/
PREFIX=$PREFIX_PATH/x86

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

echo Android x86 builds finished
