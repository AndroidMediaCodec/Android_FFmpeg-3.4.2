#!/bin/bash
. toolchain.sh
./generateToolChain.sh
pushd libx264-git

./build_android_all.sh

popd
