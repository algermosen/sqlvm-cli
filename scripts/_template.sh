#!/bin/bash
set -e

# 👉 Define defaults here
SHOW_HELP=false
POSITIONAL=()

# ✅ Parse flags
while [[ $# -gt 0 ]]; do
  case "$1" in
    --help|-h)
      SHOW_HELP=true
      shift
      ;;
    -*)
      echo "❌ Unknown flag: $1"
      exit 1
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

# 👉 Show help if requested
if $SHOW_HELP; then
  "$(dirname "$0")/print_help.sh" $(basename "$0" .sh)
  exit 0
fi

# 👉 Main logic
echo "🎯 Running subcommand: $(basename "$0" .sh)"
echo "Positional args: ${POSITIONAL[*]}"
