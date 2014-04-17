#!/bin/sh

# This runs on the local side. The TUN_UP_SCRIPT is for OS X.
# For linux you'd use "ifconfig tun0 inet 10.4.0.1 pointopoint 10.4.0.2 up"

env \
TUN_MODE=1 \
REMOTE_ADDRESS=actual.ip-of.remote.box
REMOTE_PORT=9998 \
DEBUG=1 \
TUN_UP_SCRIPT="ifconfig utun0 inet 10.4.0.1 10.4.0.2 up" \
PRIVATE_KEY="run quicktun.keypair LOCALLY and paste the SECRET key here" \
PUBLIC_KEY="run quicktun.keypair REMOTELY and paste the PUBLIC key here" \
./quicktun
