#!/bin/bash

COMMAND="$1"

# Show help for a valid subcommand
if [[ -n "$COMMAND" && -f "$HOME/bin/sqlvm-cli/scripts/${COMMAND}.sh" ]]; then
  echo "Use: sqlvm $COMMAND --help"
  exit 0
fi

# If the command is given and is not a script, print detailed help or unknown
if [[ -n "$COMMAND" ]]; then
  if [[ -f "$HOME/bin/sqlvm-cli/scripts-cli/print_help.sh" ]]; then
    "$HOME/bin/sqlvm-cli/scripts/print_help.sh" "$COMMAND"
  else
    echo "Unknown command: $COMMAND"
  fi
  exit 1
fi

# Default fallback: list commands
echo "🛠 Available commands:"
for f in "$HOME/bin/sqlvm-cli/scripts/"*.sh; do
  name=$(basename "$f" .sh)
  printf "  %-12s\n" "$name"
done

echo ""
echo "Run 'sqlvm <command>' or 'sqlvm help <command>'"
exit 0
