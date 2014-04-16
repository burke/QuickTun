#!/bin/sh
set -e

tar="tar"
cc="cc"

if [ "$(uname -s)" = "Darwin" ]; then
	tar="gnutar"
	cc="clang"
fi

echo Cleaning up...
rm -rf out/ obj/ tmp/
mkdir -p out obj tmp/include

export LIBRARY_PATH="/usr/local/lib/:${LIBRARY_PATH}"

CFLAGS="$CFLAGS -DQT_VERSION=\"`cat VERSION`\""

echo Building binaries...
$cc $CFLAGS -o out/quicktun	src/proto.nacltai.c	-lsodium $LDFLAGS
$cc $CFLAGS -o out/quicktun.keypair	src/keypair.c		-lsodium $LDFLAGS

