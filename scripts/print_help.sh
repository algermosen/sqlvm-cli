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

  Default [ISO_NAME]: ubuntu-22.04.5-live-server-amd64.iso

Flags:
  --disk-size SIZE     Set the virtual disk size (default: 20G)
  --force              Recreate ISO/disk even if they exist (default: false)
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
    --port PORT         Set the SSH port (default: 2222)
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
    --force             Force stop the VM without waiting for graceful shutdown (default: false)
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
    --force             Force stop the VM without waiting for graceful shutdown (default: false)
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
ip)
  cat <<EOF
Usage:
  sqlvm ip [--port]

Description:
  Displays the IP address or port of the SQL VM.

Flags:
  --port             Show only the forwarded port (default: 1433)
  --help             Show this help message

Examples:
  sqlvm ip
  sqlvm ip --port
EOF
  ;;
ready)
  cat <<EOF
Usage:
  sqlvm ready [--host HOST] [--port PORT]

Description:
  Checks if the SQL VM is ready to accept connections.

Flags:
  --host HOST        Specify the host (default: 127.0.0.1)
  --port PORT        Specify the port (default: 1433)
  --help             Show this help message

Examples:
  sqlvm ready
  sqlvm ready --host

EOF
  ;;
rebuild)
  cat <<EOF
Usage:
  sqlvm rebuild [--disk-size SIZE] [--force]

Description:
  Rebuilds the SQL VM from scratch, removing existing data and configurations.

Flags:
  --disk-size SIZE   Set the virtual disk size (default: 20G)
  --force            Force rebuild even if the VM is running (default: false)
  --help             Show this help message

Examples:
  sqlvm rebuild
  sqlvm rebuild --disk-size 30G
  sqlvm rebuild --force
EOF
  ;;
uninstall)
  cat <<EOF
Usage:
  sqlvm uninstall [--dry-run] [--force-user]

Description:
  Uninstalls the SQL VM from your system.

Flags:
  --dry-run           Show what would be done without making changes (default: false)
  --force-user        Force uninstall for the current user even if the VM is running (default: false)
  --help              Show this help message

Examples:
  sqlvm uninstall
  sqlvm uninstall --dry-run
  sqlvm uninstall --force-user
EOF
  ;;
backup)
  cat <<EOF
Usage:
  sqlvm backup [--output FILE]

Description:
  Backs up the SQL VM data to a specified file.

Flags:
  --output FILE       Specify the output file for the backup (default: sqlvm_backup.tar.gz)
  --help              Show this help message

Examples:
  sqlvm backup
  sqlvm backup --output my_backup.tar.gz
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
  init, up, down, uninstall, logs, ssh, ip, ready, rebuild, status, backup, restart

Examples:
  sqlvm help init
  sqlvm help up
  sqlvm help down
  sqlvm help uninstall
  sqlvm help logs
EOF
  ;;
--version | -v)
  cat <<EOF
Show SQL VM CLI Version
EOF
  ;;
*)
  echo "No help available for command: $CMD"
  ;;
esac
