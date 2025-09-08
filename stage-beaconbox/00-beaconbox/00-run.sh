#!/bin/bash
set -e

install -m 0755 -o root -g root -d "${ROOTFS_DIR}/etc/beaconbox"
cp -r /stage2/99-beaconbox/etc/* "${ROOTFS_DIR}/etc/"

install -m 0755 -o root -g root -d "${ROOTFS_DIR}/usr/local/bin"
cp -r /stage2/99-beaconbox/usr/local/bin/* "${ROOTFS_DIR}/usr/local/bin/"

install -m 0755 -o root -g root -d "${ROOTFS_DIR}/srv/beaconbox"
cp -r /stage2/99-beaconbox/srv/* "${ROOTFS_DIR}/srv/"
