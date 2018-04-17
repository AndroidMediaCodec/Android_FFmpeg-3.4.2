#!/bin/bash

TOOLCHAIN=$TOOLCHAIN_ARM
HOST=arm-linux
CROSS_PREFIX=$TOOLCHAIN/bin/arm-linux-androideabi-

SYSROOT=$TOOLCHAIN/sysroot
PREFIX=$PREFIX_PATH/armv7

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

function build_ARMv7
{
  make clean
  ./configure \
  --target-os=linux \
  --prefix=$PREFIX \
  ${GENERAL} \
  --sysroot=$SYSROOT \
  --enable-shared \
  --enable-static \
  --extra-cflags="-DANDROID -D__thumb__ -mthumb -Wfatal-errors -Wno-deprecated -fPIC -ffunction-sections -funwind-tables -fstack-protector -march=armv7-a -mfloat-abi=softfp -mfpu=vfpv3-d16 -fomit-frame-pointer -fstrict-aliasing -funswitch-loops -finline-limit=300" \
  --extra-ldflags="-Wl,-rpath-link=$SYSROOT/usr/lib -L$SYSROOT/usr/lib -nostdlib -lc -lm -ldl -llog" \
  --enable-zlib \
  ${MODULES} \
  --disable-doc \
  --enable-neon

 make -j$(nproc) install || exit 1
}

build_ARMv7
echo Android ARMv7-a builds finished
