#!/bin/bash
set -e

SHOW_HELP=false
FOLLOW=false
POSITIONAL=()

# Parse flags
while [[ $# -gt 0 ]]; do
  case "$1" in
    --follow|-f)
      FOLLOW=true
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
  "$(dirname "$0")/print_help.sh" logs
  exit 0
fi

LOG_DIR="$(pwd)/data/var/opt/mssql/log"
LOG_FILE="$LOG_DIR/errorlog"

if [[ ! -f "$LOG_FILE" ]]; then
  echo "Log file not found: $LOG_FILE"
  exit 1
fi

if $FOLLOW; then
  echo "Following SQL Server log: $LOG_FILE"
  tail -f "$LOG_FILE"
else
  echo "Showing SQL Server log: $LOG_FILE"
  cat "$LOG_FILE"
fi
