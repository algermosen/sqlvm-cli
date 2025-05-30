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

# Choose install path
if $FORCE_USER; then
  TARGET_BIN="$HOME/bin"
  mkdir -p "$TARGET_BIN"
  log "Forcing install to user bin: $TARGET_BIN"
else
  if [[ $(uname -m) == "arm64" && -d "/opt/homebrew/bin" && -w "/opt/homebrew/bin" ]]; then
    TARGET_BIN="/opt/homebrew/bin"
  elif [[ -d "/usr/local/bin" && -w "/usr/local/bin" ]]; then
    TARGET_BIN="/usr/local/bin"
  else
    TARGET_BIN="$HOME/bin"
    mkdir -p "$TARGET_BIN"
    log "Fallback to user bin: $TARGET_BIN"
  fi
fi

log "Target bin directory: $TARGET_BIN"

# Install CLI
log "Installing sqlvm to $TARGET_BIN"
$DRY_RUN || cp sqlvm "$TARGET_BIN/sqlvm"

# Make everything executable
log "Making sqlvm executable"
$DRY_RUN || chmod +x "$TARGET_BIN/sqlvm"

log "Making release and version scripts executable"
$DRY_RUN || chmod +x release.sh version.sh

log "Making all subcommands in scripts/ executable"
$DRY_RUN || find scripts/ -type f -name '*.sh' -exec chmod +x {} \;

# Update PATH if ~/bin used
if [[ "$TARGET_BIN" == "$HOME/bin" ]]; then
  SHELL_NAME=$(basename "$SHELL")
  SHELL_RC="$HOME/.zshrc"
  [[ "$SHELL_NAME" == "bash" ]] && SHELL_RC="$HOME/.bashrc"

  if ! grep -q "$HOME/bin" "$SHELL_RC"; then
    log "Adding '~/bin' to PATH in $SHELL_RC"
    $DRY_RUN || echo 'export PATH="$HOME/bin:$PATH"' >> "$SHELL_RC"
    log "Run: source $SHELL_RC"
    echo "ℹ️ Run: source $SHELL_RC or open a new terminal window to use 'sqlvm'"
  else
    log "PATH already contains ~/bin"
  fi
fi

log "✅ sqlvm install script complete."