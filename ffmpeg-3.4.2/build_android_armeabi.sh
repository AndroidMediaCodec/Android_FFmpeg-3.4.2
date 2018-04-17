#!/bin/bash

TOOLCHAIN=$TOOLCHAIN_ARM
HOST=arm-linux
CROSS_PREFIX=$TOOLCHAIN/bin/arm-linux-androideabi-

SYSROOT=$TOOLCHAIN/sysroot
PREFIX=$PREFIX_PATH/arm

GENERAL="\
--enable-small \
--enable-cross-compile \
--enable-runtime-cpudetect \
--disable-asm \
--extra-libs="-lgcc" \
--arch=arm \
--cc=$TOOLCHAIN/bin/arm-linux-androideabi-gcc \
--cross-prefix=$CROSS_PREFIX \
--nm=$TOOLCHAIN/bin/arm-linux-androideabi-nm \
--extra-cflags="-I../prefix/arm/include" \
--extra-ldflags="-L../prefix/arm/lib" "


MODULES="\
--enable-gpl \
--enable-libx264"

function build_ARMv6
{
  make clean
  ./configure \
  --target-os=linux \
  --prefix=$PREFIX \
  ${GENERAL} \
  --sysroot=$SYSROOT \
  --enable-shared \
  --enable-static \
  --extra-cflags=" -O3 -fpic -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -finline-limit=300 -mfloat-abi=softfp -mfpu=vfp -DANDROID -D__thumb__ -mthumb -Wfatal-errors -Wno-deprecated -mfloat-abi=softfp -marm -march=armv6" \
  --extra-ldflags="-lx264 -Wl,-rpath-link=$SYSROOT/usr/lib -L$SYSROOT/usr/lib -nostdlib -lc -lm -ldl -llog" \
  --enable-zlib \
  ${MODULES} \
  --disable-doc \
  --enable-neon

  make -j$(nproc) install || exit 1
}



build_ARMv6

echo Android ARMEABI builds finished
