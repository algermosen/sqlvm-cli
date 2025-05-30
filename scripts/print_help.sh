#!/bin/bash

CMD="$1"

case "$CMD" in
init)
    cat <<EOF
Usage:
  sqlvm init [ISO_NAME] [--disk-size SIZE] [--force]

Description:
  Initializes the virtual disk and ISO needed to run the SQL VM.

  You can find compatible iso files from https://releases.ubuntu.com/22.04/

  Default: ubuntu-22.04.5-live-server-amd64.iso

Flags:
  --disk-size SIZE     Set the virtual disk size (e.g., 20G)
  --force              Recreate ISO/disk even if they exist
  --help               Show this help message

Examples:
  sqlvm init
  sqlvm init --disk-size 30G
  sqlvm init ubuntu.iso --disk-size 25G --force
EOF
    ;;
up)
    cat <<EOF
Usage:
  sqlvm up [--headless]

Description:
  Starts the SQL virtual machine.

Flags:
  --headless           Run QEMU without opening a display
  --help               Show this help message
EOF
    ;;
*)
    echo "❌ No help available for command: $CMD"
    ;;
uninstall)
    cat <<EOF
Usage:
  sqlvm uninstall [--dry-run] [--force-user]

Description:
  Uninstalls the SQL VM from your system.

Flags:
  --dry-run           Show what would be done without making changes
  --force-user        Force uninstall for the current user
  --help              Show this help message
  
Examples:
  sqlvm uninstall
  sqlvm uninstall --dry-run
  sqlvm uninstall --force-user
EOF
    ;;
esac
