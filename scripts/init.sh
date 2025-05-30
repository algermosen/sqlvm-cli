#!/bin/bash
set -e

# Defaults
DISK_SIZE="20G"
FORCE=false
SHOW_HELP=false
POSITIONAL=()

# Parse flags and args
while [[ $# -gt 0 ]]; do
  case "$1" in
    --disk-size)
      DISK_SIZE="$2"
      shift 2
      ;;
    --force)
      FORCE=true
      shift
      ;;
    --help|-h)
      SHOW_HELP=true
      shift
      ;;
    -*)
      echo "Unknown option: $1"
      exit 1
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

# Get ISO from arg or use default
ISO_NAME="${POSITIONAL[0]:-ubuntu-22.04.5-live-server-amd64.iso}"
ISO_URL="https://releases.ubuntu.com/22.04/$ISO_NAME"
IMG_NAME="ubuntu.img"

# Show help if needed
if $SHOW_HELP; then
  "$(dirname "$0")/print_help.sh" init
  exit 0
fi

# Info
echo "Creating SQL VM base files..."
echo "ISO: $ISO_NAME"
echo "Disk size: $DISK_SIZE"
echo ""

# Download ISO if needed
if [[ ! -f "$ISO_NAME" || "$FORCE" == true ]]; then
  echo "Downloading ISO from $ISO_URL..."
  curl -LO "$ISO_URL"
else
  echo "ISO already exists: $ISO_NAME"
fi

# Create VM disk image
if [[ ! -f "$IMG_NAME" || "$FORCE" == true ]]; then
  echo "💽 Creating virtual disk: $IMG_NAME ($DISK_SIZE)"
  qemu-img create -f qcow2 "$IMG_NAME" "$DISK_SIZE"
else
  echo "Virtual disk already exists: $IMG_NAME"
fi

echo ""
echo "Initialization complete."
