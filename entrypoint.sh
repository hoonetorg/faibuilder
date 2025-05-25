#!/usr/bin/env bash
# entrypoint.sh

set -euo pipefail

# Ensure directories exist
mkdir -p "${MIRROR_DIR}" "${OUTPUT_DIR}"

echo ">> Starting fai-mirror..."
fai-mirror -b \
           -C /etc/fai-ubuntu \
           -m1 \
           -c"${CL}" \
           "${MIRROR_DIR}"

echo ">> Building ISO with fai-cd..."
fai-cd     -C /etc/fai-ubuntu \
           -g grub.cfg.install-only \
           -m "${MIRROR_DIR}" \
           "${OUTPUT_DIR}/faicd.iso"

echo ">> Done: your ISO is at ${OUTPUT_DIR}/faicd.iso"

