#!/bin/bash
set -e

SHOW_HELP=false
FORCE=false
POSITIONAL=()

# Parse flags
while [[ $# -gt 0 ]]; do
  case "$1" in
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
  "$(dirname "$0")/print_help.sh" restart
  exit 0
fi

# Reuse down + up logic
"$(dirname "$0")/down.sh" ${FORCE:+--force}
"$(dirname "$0")/up.sh"
