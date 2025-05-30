#!/bin/bash

CMD="$1"

case "$CMD" in
init)
  cat <<EOF
Usage:
  sqlvm init [ISO_NAME] [--disk-size SIZE] [--force]

Description:
  Initializes the virtual disk and ISO needed to run the SQL VM.

  You can find compatible iso files from https://releases.ubuntu.com/22.04/

  Default: ubuntu-22.04.5-live-server-amd64.iso

Flags:
  --disk-size SIZE     Set the virtual disk size (e.g., 20G)
  --force              Recreate ISO/disk even if they exist
  --help               Show this help message

Examples:
  sqlvm init
  sqlvm init --disk-size 30G
  sqlvm init ubuntu.iso --disk-size 25G --force
EOF
  ;;
up)
  cat <<EOF
Usage:
    sqlvm up [--headless] [--memory SIZE] [--cpus COUNT]

Description:
    Starts the SQL VM with the specified configuration.

Flags:
    --headless          Run in headless mode (no GUI)
    --memory SIZE       Set the amount of memory (default: 4096M)
    --cpus COUNT        Set the number of CPUs (default: 2)
    --help              Show this help message

Examples:
    sqlvm up
    sqlvm up --headless
    sqlvm up --memory 8192 --cpus 4
EOF
  ;;
down)
  cat <<EOF
Usage:
    sqlvm down [--force]

Description:
    Stops the SQL VM gracefully or forcefully.

Flags:
    --force             Force stop the VM without waiting
    --help              Show this help message

Examples:
    sqlvm down
    sqlvm down --force
EOF
  ;;
restart)
  cat <<EOF
Usage:
    sqlvm restart [--force]

Description:
    Restarts the SQL VM by stopping and starting it again.

Flags:
    --force             Force stop the VM without waiting
    --help              Show this help message

Examples:
    sqlvm restart
    sqlvm restart --force
EOF
  ;;
status)
  cat <<EOF
Usage:
  sqlvm status

Description:
  Displays the current status of the SQL VM.

Examples:
  sqlvm status
EOF
  ;;
ssh)
  cat <<EOF
Usage:
  sqlvm ssh [--user USER] [--port PORT]

Description:
  Connects to the SQL VM via SSH.

Flags:
  --user USER         Specify the SSH user (default: algermosen)
  --port PORT         Specify the SSH port (default: 2222)
  --help              Show this help message

Examples:
  sqlvm ssh
  sqlvm ssh --user myuser --port 2223
EOF
  ;;
uninstall)
  cat <<EOF
Usage:
  sqlvm uninstall [--dry-run] [--force-user]

Description:
  Uninstalls the SQL VM from your system.

Flags:
  --dry-run           Show what would be done without making changes
  --force-user        Force uninstall for the current user
  --help              Show this help message

Examples:
  sqlvm uninstall
  sqlvm uninstall --dry-run
  sqlvm uninstall --force-user
EOF
  ;;
logs)
  cat <<EOF
Usage:
  sqlvm logs [--follow]

Description:
  Displays the SQL Server logs.

Flags:
    --follow           Follow the log output in real-time
    --help             Show this help message

Examples:
    sqlvm logs
    sqlvm logs --follow
EOF
  ;;
help | -h)
  cat <<EOF
Usage:
  sqlvm help <command>

Description:
  Displays help for a specific command.

Commands:
  init, up, down, uninstall, logs

Examples:
  sqlvm help init
  sqlvm help up
  sqlvm help down
  sqlvm help uninstall
  sqlvm help logs
EOF
  ;;
*)
  echo "No help available for command: $CMD"
  ;;
esac
