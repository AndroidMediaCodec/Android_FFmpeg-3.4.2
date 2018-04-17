#!/bin/bash
#/media/dastaniqbal/OS/Tools/android-ndk-r14b/build/tools/make_standalone_toolchain.py --arch arm --api 21 --force --install-dir=../toolchain-android-arm

TOOLCHAIN=$TOOLCHAIN_ARM
HOST=arm-linux
CROSS_PREFIX=$TOOLCHAIN/bin/arm-linux-androideabi-

SYSROOT=$TOOLCHAIN/sysroot
PREFIX=$PREFIX_PATH/arm

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

echo Android ARM builds finished
