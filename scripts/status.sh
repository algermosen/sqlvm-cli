#!/bin/bash
set -e

SHOW_HELP=false
POSITIONAL=()

while [[ $# -gt 0 ]]; do
  case "$1" in
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
  "$(dirname "$0")/print_help.sh" status
  exit 0
fi

PID=$(pgrep -f "qemu-system-x86_64.*ubuntu.img")

if [[ -n "$PID" ]]; then
  echo "SQL VM is running (PID $PID)"
else
  echo "SQL VM is not running."
fi
