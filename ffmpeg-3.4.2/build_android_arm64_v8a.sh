#!/bin/bash

TOOLCHAIN=$TOOLCHAIN_ARM64
HOST=aarch64-linux
CROSS_PREFIX=$TOOLCHAIN/bin/aarch64-linux-android-

SYSROOT=$TOOLCHAIN/sysroot
PLATFORM=$TOOLCHAIN/platforms/android-21/arch-arm64/
PREFIX=$PREFIX_PATH/arm64

GENERAL="\
--enable-small \
--enable-cross-compile \
--enable-runtime-cpudetect \
--disable-asm \
--extra-libs="-lgcc" \
--arch=arm64 \
--cc=$TOOLCHAIN/bin/aarch64-linux-android-gcc \
--cross-prefix=$TOOLCHAIN/bin/aarch64-linux-android- \
--nm=$TOOLCHAIN/bin/aarch64-linux-android-nm \
--extra-cflags="-I../prefix/arm64/include" \
--extra-ldflags="-L../prefix/arm64/lib" "

MODULES="\
--enable-gpl \
--enable-libx264"



function build_arm64
{
  make clean
  ./configure \
  --logfile=conflog.txt \
  --target-os=linux \
  --prefix=$PREFIX \
  ${GENERAL} \
  --sysroot=$SYSROOT \
  --enable-shared \
  --enable-static \
  --extra-cflags="" \
  --extra-ldflags="-Wl,-rpath-link=$SYSROOT/usr/lib -L$SYSROOT/usr/lib -nostdlib -lc -lm -ldl -llog" \
  --disable-doc \
  --enable-zlib \
  ${MODULES}

  make -j$(nproc) install || exit 1
}

build_arm64


echo Android ARM64 builds finished
