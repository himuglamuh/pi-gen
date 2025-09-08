OVERLAY_DIR="$(dirname "$0")/../overlay"

if [ -d "${OVERLAY_DIR}" ]; then
    echo "Applying overlay from ${OVERLAY_DIR} to ${ROOTFS_DIR}..."
    cp -ar "${OVERLAY_DIR}/." "${ROOTFS_DIR}/"
else
    echo "Overlay directory not found: ${OVERLAY_DIR}"
    exit 1
fi
