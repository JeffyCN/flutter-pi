#!/bin/sh

#export SDKDIR=${TARGET_OUTPUT_DIR:-/nvme/buildroot/output/rockchip_px30_32}

export SDKDIR=${TARGET_OUTPUT_DIR:-/nvme/buildroot/output/rockchip_px30_64}
export CROSS_COMPILE=arm-buildroot-linux-gnueabihf-
export BINARY_DIR=prebuild/armhf

if [ ! -e "${SDKDIR}/host/bin/${CROSS_COMPILE}gcc" ]; then
	export CROSS_COMPILE=aarch64-buildroot-linux-gnu-
	export BINARY_DIR=prebuild/aarch64
fi

ln -sf ${BINARY_DIR} binary

CFLAGS="-D_LARGEFILE_SOURCE -D_LARGEFILE64_SOURCE -D_FILE_OFFSET_BITS=64  -Os \
  -I${BINARY_DIR} " \
LDFLAGS=" -lstdc++ -lm -L${BINARY_DIR} " \
/usr/bin/make -j8 -f Makefile CC="${SDKDIR}/host/bin/${CROSS_COMPILE}gcc" LD="${SDKDIR}/host/bin/${CROSS_COMPILE}gcc" PKG_CONFIG="${SDKDIR}/host/bin/pkg-config" -B $@
