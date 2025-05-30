#!/bin/bash
chmod +x sqlvm
ln -sf "$(pwd)/sqlvm" "$HOME/bin/sqlvm"
echo "✅ sqlvm is now available as a global command."

