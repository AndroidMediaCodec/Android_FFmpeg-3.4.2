#!/bin/bash
TOOLCHAIN=$TOOLCHAIN_x86
HOST=i686-linux
CROSS_PREFIX=$TOOLCHAIN/bin/i686-linux-android-

SYSROOT=$TOOLCHAIN/sysroot
PLATFORM=$TOOLCHAIN/platforms/android-21/arch-x86/
PREFIX=$PREFIX_PATH/x86

GENERAL="\
--enable-small \
--enable-cross-compile \
--enable-runtime-cpudetect \
--disable-asm \
--extra-libs="-lgcc" \
--cc=$TOOLCHAIN/bin/i686-linux-android-gcc \
--cross-prefix=$TOOLCHAIN/bin/i686-linux-android- \
--nm=$TOOLCHAIN/bin/i686-linux-android-nm \
--extra-cflags="-I../prefix/x86/include" \
--extra-ldflags="-L../prefix/x86/lib" "

MODULES="\
--enable-gpl \
--enable-libx264"


function build_x86
{
  make clean
  ./configure \
  --logfile=conflog.txt \
  --target-os=linux \
  --prefix=$PREFIX \
  --arch=x86 \
  ${GENERAL} \
  --sysroot=$SYSROOT \
  --extra-cflags=" -O3 -DANDROID -Dipv6mr_interface=ipv6mr_ifindex -fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -fomit-frame-pointer -march=k8" \
  --enable-shared \
  --enable-static \
  --extra-cflags="-march=i686 -mtune=intel -mssse3 -mfpmath=sse -m32" \
  --extra-ldflags="-lx264 -Wl,-rpath-link=$SYSROOT/usr/lib -L$SYSROOT/usr/lib -nostdlib -lc -lm -ldl -llog" \
  --enable-zlib \
  --disable-doc \
  ${MODULES}

  
  make -j$(nproc) install || exit 1
}

build_x86


echo Android X86 builds finished
