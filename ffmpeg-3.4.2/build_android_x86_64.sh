#!/bin/bash
TOOLCHAIN=$TOOLCHAIN_x86_64
HOST=x86_64-linux
CROSS_PREFIX=$TOOLCHAIN/bin/x86_64-linux-android-

SYSROOT=$TOOLCHAIN/sysroot
PLATFORM=$TOOLCHAIN/platforms/android-21/arch-x86_64/
PREFIX=$PREFIX_PATH/x86_64

GENERAL="\
--enable-small \
--enable-cross-compile \
--enable-runtime-cpudetect \
--disable-asm \
--extra-libs="-lgcc" \
--cc=$TOOLCHAIN/bin/x86_64-linux-android-gcc \
--cross-prefix=$TOOLCHAIN/bin/x86_64-linux-android- \
--nm=$TOOLCHAIN/bin/x86_64-linux-android-nm \
--extra-cflags="-I../prefix/x86_64/include" \
--extra-ldflags="-L../prefix/x86_64/lib" "

MODULES="\
--enable-gpl \
--enable-libx264"


function build_x86_64
{
  make clean
  ./configure \
  --logfile=conflog.txt \
  --target-os=linux \
  --prefix=$PREFIX \
  --arch=x86_64 \
  ${GENERAL} \
  --sysroot=$SYSROOT \
  --extra-cflags="-march=x86-64 -msse4.2 -mpopcnt -m64 -mtune=intel" \
  --enable-shared \
  --enable-static \
  --extra-ldflags="-lx264 -Wl,-rpath-link=$SYSROOT/usr/lib64 -L$SYSROOT/usr/lib64 -nostdlib -lc -lm -ldl -llog" \
  --enable-zlib \
  --disable-doc \
  ${MODULES}

 make -j$(nproc) install || exit 1
}

build_x86_64


echo Android X86_64 builds finished
