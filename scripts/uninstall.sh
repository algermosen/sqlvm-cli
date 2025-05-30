#!/bin/bash
set -e

FORCE_USER=false
DRY_RUN=false
SHOW_HELP=false
POSITIONAL=()

# Flag parsing
while [[ $# -gt 0 ]]; do
  case "$1" in
    --dry-run)
      DRY_RUN=true
      shift
      ;;
    --force-user)
      FORCE_USER=true
      shift
      ;;
    --help|-h)
      SHOW_HELP=true
      shift
      ;;
    -*)
      echo "Unknown flag: $1"
      exit 1
      ;;
    *)
      POSITIONAL+=("$1")
      shift
      ;;
  esac
done

# Help message
if $SHOW_HELP; then
  "$(dirname "$0")/print_help.sh" uninstall
  exit 0
fi

log() {
  if $DRY_RUN; then
    echo "[DRY-RUN] $1"
  else
    echo "$1"
  fi
}

# Possible install locations
BIN_PATHS=(
  "/opt/homebrew/bin/sqlvm"
  "/usr/local/bin/sqlvm"
  "$HOME/bin/sqlvm"
)

TARGET_PATH=""
if $FORCE_USER; then
  TARGET_PATH="$HOME/bin/sqlvm"
else
  for path in "${BIN_PATHS[@]}"; do
    if [[ -f "$path" ]]; then
      TARGET_PATH="$path"
      break
    fi
  done
fi

if [[ -z "$TARGET_PATH" ]]; then
  echo "sqlvm was not found in a known location."
  exit 1
fi

log "Removing CLI entry: $TARGET_PATH"
$DRY_RUN || rm -f "$TARGET_PATH"

# Clean up PATH if in user bin
if [[ "$TARGET_PATH" == "$HOME/bin/sqlvm" ]]; then
  SHELL_NAME=$(basename "$SHELL")
  SHELL_RC="$HOME/.zshrc"
  [[ "$SHELL_NAME" == "bash" ]] && SHELL_RC="$HOME/.bashrc"

  log "Cleaning PATH reference in $SHELL_RC (if exists)"
  $DRY_RUN || sed -i.bak '/export PATH="\$HOME\/bin:\$PATH"/d' "$SHELL_RC"
fi

# Optional project directory removal
read -p "Do you want to remove the project directory at $(pwd)? (y/N): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  log "Removing project directory: $(pwd)"
  $DRY_RUN || rm -rf "$(pwd)"
else
  log "Project directory left untouched."
fi

log "sqlvm successfully uninstalled."
