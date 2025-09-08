OVERLAY_DIR="/pi-gen/overlay"

if [ -d "${OVERLAY_DIR}" ]; then
    echo "Applying overlay from ${OVERLAY_DIR} to /..."
    cp -ar "${OVERLAY_DIR}/." /
else
    echo "Overlay directory not found: ${OVERLAY_DIR}"
    exit 1
fi
