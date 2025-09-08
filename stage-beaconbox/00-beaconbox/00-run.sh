#!/bin/bash -e

echo "✅ Running beaconbox stage setup..."

mkdir -p "${ROOTFS_DIR}"

rsync -a --chown=1000:1000 "/pi-gen/common-overlay/" "${ROOTFS_DIR}/"

mkdir -p "${ROOTFS_DIR}/etc/beaconbox"
touch "${ROOTFS_DIR}/etc/beaconbox/.installed"
