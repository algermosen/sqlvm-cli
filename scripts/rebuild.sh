#!/bin/bash
set -e

SHOW_HELP=false
DISK_SIZE="20G"
FORCE=false
POSITIONAL=()

# Parse flags
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
    -*|--*)
      echo "Unknown flag: $1"
      exit 1
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

if $SHOW_HELP; then
  "$(dirname "$0")/print_help.sh" rebuild
  exit 0
fi

echo "Rebuilding SQL VM from scratch..."

"$(dirname "$0")/down.sh" ${FORCE:+--force}
"$(dirname "$0")/uninstall.sh" --force-user
"$(dirname "$0")/init.sh" --disk-size "$DISK_SIZE"
"$(dirname "$0")/up.sh"

echo "Rebuild complete."
