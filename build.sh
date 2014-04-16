#!/bin/sh
set -e

tar="tar"
cc="cc"

if [ "$(uname -s)" = "OpenBSD" -o "$(uname -s)" = "FreeBSD" -o "$(uname -s)" = "NetBSD" ]; then
	echo "Detected *BSD"
	tar="gtar"
	export CPATH="/usr/local/include:${CPATH}"
elif [ "$(uname -s)" = "SunOS" ]; then
	echo "Detected SunOS"
	tar="gtar"
	CFLAGS="$CFLAGS -DSOLARIS -m64"
	LDFLAGS="$LDFLAGS -lnsl -lsocket"
elif [ "$(uname -s)" = "Darwin" ]; then
	echo "Detected Mac OS X (Darwin)"
	tar="gnutar"
	cc="clang"
fi

echo Cleaning up...
rm -rf out/ obj/ tmp/

mkdir -p out
echo Creating source archive...
$tar --transform "s,^,quicktun-`cat VERSION`/," -czf "out/quicktun-`cat VERSION`.tgz" build.sh clean.sh debian src VERSION --exclude "debian/data"

mkdir -p obj tmp tmp/include

export LIBRARY_PATH="/usr/local/lib/:${LIBRARY_PATH}"

CFLAGS="$CFLAGS -DQT_VERSION=\"`cat VERSION`\""

echo Building binaries...
$cc $CFLAGS -o out/quicktun	src/proto.nacltai.c	-lsodium $LDFLAGS
$cc $CFLAGS -o out/quicktun.keypair	src/keypair.c		-lsodium $LDFLAGS

if [ -f /etc/network/interfaces ]; then
	echo Building debian binary...
  $cc $CFLAGS -DDEBIAN_BINARY -o out/quicktun	src/proto.nacltai.c	-lsodium $LDFLAGS
	if [ -x /usr/bin/dpkg-deb -a -x /usr/bin/fakeroot ]; then
		echo -n Building debian package...
		cd debian
		./build.sh
		cd ..
	fi
fi

