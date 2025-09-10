#!/bin/bash -e

echo "👉 Running beaconbox stage setup..."

mkdir -p "${ROOTFS_DIR}"

echo "👉 Copying common overlay files..."
rsync -a --chown=1000:1000 "/pi-gen/common-overlay/" "${ROOTFS_DIR}/"

echo "👉 Setting beaconbox net and web services..."
chroot "${ROOTFS_DIR}" systemctl enable beaconbox-net.service
chroot "${ROOTFS_DIR}" systemctl enable beaconbox-web.service
chroot "${ROOTFS_DIR}" systemctl enable nftables.service

echo "👉 Touching beaconbox installed file..."
mkdir -p "${ROOTFS_DIR}/etc/beaconbox"
touch "${ROOTFS_DIR}/etc/beaconbox/.installed"

echo "✅ beaconbox stage setup complete!"
