#!/bin/bash
. toolchain.sh
./generateToolChain.sh
pushd ffmpeg-3.4.2

./build_android_all.sh

popd
