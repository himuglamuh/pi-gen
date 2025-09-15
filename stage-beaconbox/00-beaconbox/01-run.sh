#!/bin/bash -e

echo "👉 Running beaconbox stage setup..."

mkdir -p "${ROOTFS_DIR}"

echo "👉 Copying common overlay files..."
rsync -a --chown=1000:1000 "/pi-gen/common-overlay/" "${ROOTFS_DIR}/"

echo "👉 Setting permissions on /etc/sudoers.d and system files..."
chown root:root "${ROOTFS_DIR}/etc/sudoers.d"
chmod 755 "${ROOTFS_DIR}/etc/sudoers.d"
find "${ROOTFS_DIR}/etc/sudoers.d" -type f -exec chown root:root {} \;
find "${ROOTFS_DIR}/etc/sudoers.d" -type f -exec chmod 440 {} \;
find "${ROOTFS_DIR}/etc/systemd/system" -name '*.service' -exec chown root:root {} \;

echo "👉 Disabling unnecessary services to speed up boot..."

DISABLE_SERVICES=(
  NetworkManager-wait-online.service
  NetworkManager.service
  ModemManager.service
  avahi-daemon.service
  bluetooth.service
  wpa_supplicant.service
  systemd-timesyncd.service
  alsa-restore.service
  systemd-zram-setup@zram0.service
  keyboard-setup.service
  console-setup.service
  systemd-hostnamed.service
  udisks2.service
  e2scrub_reap.service
  rpi-eeprom-update.service
  rpi-resize-swap-file.service
  modprobe@drm.service
)

for svc in "${DISABLE_SERVICES[@]}"; do
  echo "   ➤ Disabling $svc"
  chroot "${ROOTFS_DIR}" systemctl disable "$svc" || true
done

echo "👉 Setting beaconbox net and web services..."
chroot "${ROOTFS_DIR}" systemctl disable dnsmasq.service || true
chroot "${ROOTFS_DIR}" systemctl enable beaconbox-net.service
chroot "${ROOTFS_DIR}" systemctl enable beaconbox-web.service
chroot "${ROOTFS_DIR}" systemctl enable beaconbox-dns.service
chroot "${ROOTFS_DIR}" systemctl enable nftables.service

echo "👉 Touching beaconbox installed file..."
mkdir -p "${ROOTFS_DIR}/etc/beaconbox"
touch "${ROOTFS_DIR}/etc/beaconbox/.installed"

echo "✅ beaconbox stage setup complete!"
