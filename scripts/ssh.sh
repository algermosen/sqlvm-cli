#!/bin/bash
set -e

SHOW_HELP=false
USER="algermosen"
PORT=2222
POSITIONAL=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --user)
      USER="$2"
      shift 2
      ;;
    --port)
      PORT="$2"
      shift 2
      ;;
    --help|-h)
      SHOW_HELP=true
      shift
      ;;
    -*|--*)
      echo "❌ Unknown flag: $1"
      exit 1
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

if $SHOW_HELP; then
  "$(dirname "$0")/print_help.sh" ssh
  exit 0
fi

CMD=(ssh -p "$PORT" "$USER@localhost")
echo "🔐 Connecting to VM via: ${CMD[*]}"
exec "${CMD[@]}"
