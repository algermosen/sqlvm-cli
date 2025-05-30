#!/bin/bash

set -e

FORCE_USER=false
DRY_RUN=false

# Parse flags
for arg in "$@"; do
  case "$arg" in
    --dry-run) DRY_RUN=true ;;
    --force-user) FORCE_USER=true ;;
    *) echo "❌ Unknown option: $arg"; exit 1 ;;
  esac
done

log() {
  if $DRY_RUN; then
    echo "🧪 [DRY-RUN] $1"
  else
    echo "$1"
  fi
}

# Figure out where it was installed
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
  echo "❌ sqlvm was not found in a known location."
  exit 1
fi

log "Removing: $TARGET_PATH"
$DRY_RUN || rm -f "$TARGET_PATH"

# Remove PATH update if user bin was used
if [[ "$TARGET_PATH" == "$HOME/bin/sqlvm" ]]; then
  SHELL_NAME=$(basename "$SHELL")
  SHELL_RC="$HOME/.zshrc"
  [[ "$SHELL_NAME" == "bash" ]] && SHELL_RC="$HOME/.bashrc"

  log "Checking for PATH line in $SHELL_RC..."
  $DRY_RUN || sed -i.bak '/export PATH="\$HOME\/bin:\$PATH"/d' "$SHELL_RC"
fi

# Optional: remove project folder
read -p "❓ Do you want to remove the project directory at $(pwd)? (y/N): " confirm
if [[ "$confirm" =~ ^[Yy]$ ]]; then
  log "Removing project directory: $(pwd)"
  $DRY_RUN || rm -rf "$(pwd)"
else
  log "⚠️ Project directory left untouched."
fi

log "✅ sqlvm successfully uninstalled."
