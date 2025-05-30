#!/bin/bash

set -e

VM_DIR="$HOME/sqlvm"
ISO_URL="https://releases.ubuntu.com/22.04/ubuntu-22.04.5-live-server-amd64.iso"
ISO_PATH="$VM_DIR/ubuntu.iso"
DISK_PATH="$VM_DIR/ubuntu.img"

mkdir -p "$VM_DIR"

echo "📥 Downloading Ubuntu Server ISO..."
curl -L -o "$ISO_PATH" "$ISO_URL"

echo "💾 Creating virtual hard disk (20GB)..."
qemu-img create -f qcow2 "$DISK_PATH" 20G

echo "✅ Initialization complete."
echo "👉 Now run:"
echo "   qemu-system-x86_64 -m 4096 -smp 2 -cpu qemu64 -cdrom $ISO_PATH -boot d -drive file=$DISK_PATH,format=qcow2 -net nic -net user,hostfwd=tcp::2222-:22"

