#!/bin/bash

chmod +x sqlvm
ln -sf "$(pwd)/sqlvm" "$HOME/bin/sqlvm-cli"

# Detect user's shell
SHELL_NAME=$(basename "$SHELL")

# Determine config file
case "$SHELL_NAME" in
  zsh)  CONFIG_FILE="$HOME/.zshrc" ;;
  bash) CONFIG_FILE="$HOME/.bashrc" ;;
  *)    CONFIG_FILE="$HOME/.profile" ;;  # fallback
esac

# Add alias if not already added
if ! grep -q "alias sqlvm=" "$CONFIG_FILE" 2>/dev/null; then
  echo 'alias sqlvm="$HOME/bin/sqlvm-cli"' >> "$CONFIG_FILE"
  echo "✅ Added alias: sqlvm → sqlvm-cli to $CONFIG_FILE"
fi

echo "✅ sqlvm installed. You can run 'sqlvm up'"
echo "ℹ️  You may need to run: source $CONFIG_FILE"

