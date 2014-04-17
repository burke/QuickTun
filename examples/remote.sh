#!/bin/sh

# This runs on the remote side. The TUN_UP_SCRIPT is for linux.

env \
TUN_MODE=1 \
REMOTE_ADDRESS=actual.ip-of.remote.box
REMOTE_PORT=9998 \
DEBUG=1 \
TUN_UP_SCRIPT="ifconfig tun0 inet 10.4.0.2 pointopoint 10.4.0.1 up" \
PRIVATE_KEY="run quicktun.keypair REMOTELY (ie. on the box that runs this side) and paste the SECRET key here" \
PUBLIC_KEY="run quicktun.keypair LOCALLY and paste the PUBLIC key here" \
./quicktun
