NDK=$ANDROID_NDK
SUPPORTED_ARCHITECTURES=(arm arm64 x86 x86_64) #armeabi-v7a arm64-v8a  x86_64 x86
for i in "${SUPPORTED_ARCHITECTURES[@]}"
do
	case $i in
	    arm )
		if [ ! -d "$TOOLCHAIN_ARM" ]; then
			echo "Toolchain not exists; Creating Toolchain for $i"
			$NDK/build/tools/make_standalone_toolchain.py --arch arm --api 21 --force --install-dir=$TOOLCHAIN_ARM
		fi
	     ;;
	  arm64 )
		if [ ! -d "$TOOLCHAIN_ARM64" ]; then
			echo "Toolchain not exists; Creating Toolchain for $i"
			$NDK/build/tools/make_standalone_toolchain.py --arch arm64 --api 21 --force --install-dir=$TOOLCHAIN_ARM64
		fi
	     ;;
  	   x86 )
		if [ ! -d "$TOOLCHAIN_x86" ]; then
			echo "Toolchain not exists; Creating Toolchain for $i"
			$NDK/build/tools/make_standalone_toolchain.py --arch x86 --api 21 --force --install-dir=$TOOLCHAIN_x86
		fi
	     ;;
	   x86_64 )
		if [ ! -d "$TOOLCHAIN_x86_64" ]; then
			echo "Toolchain not exists; Creating Toolchain for $i"
			$NDK/build/tools/make_standalone_toolchain.py --arch x86_64 --api 21 --force --install-dir=$TOOLCHAIN_x86_64
		fi
	     ;;
	esac
done




