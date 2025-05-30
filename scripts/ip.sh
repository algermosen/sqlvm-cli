#!/bin/bash
set -e

SHOW_HELP=false
PORT_ONLY=false
POSITIONAL=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --port)
      PORT_ONLY=true
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
  "$(dirname "$0")/print_help.sh" ip
  exit 0
fi

# Try to detect forwarded port for SSH (2222) or SQL (1433)
PORT_MAP=$(ps aux | grep qemu-system | grep -oE 'hostfwd=tcp::[0-9]+-:1433' || true)

if $PORT_ONLY; then
  PORT=$(echo "$PORT_MAP" | grep -oE '[0-9]+' || echo "")
  [[ -n "$PORT" ]] && echo "$PORT" || echo ""
  exit 0
fi

if [[ -n "$PORT_MAP" ]]; then
  PORT=$(echo "$PORT_MAP" | grep -oE '[0-9]+' || echo "")
  echo "SQL VM is accessible at: 127.0.0.1:$PORT"
else
  echo "No forwarded SQL port (1433) found in running QEMU process."
  exit 1
fi
