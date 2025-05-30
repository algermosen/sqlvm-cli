#!/bin/bash

UNKNOWN="$1"

if [[ -n "$UNKNOWN" && "$UNKNOWN" != "help" ]]; then
  echo "❌ Unknown command: $UNKNOWN"
  echo ""
fi

echo "🛠 Available commands:"

for f in "$HOME/bin/sqlvm/scripts/"*.sh; do
    name=$(basename "$f" .sh)
    printf "  %-12s\n" "$name"
done

echo ""
echo "ℹ️  Run 'sqlvm <command>' to use a subcommand."
exit 1
