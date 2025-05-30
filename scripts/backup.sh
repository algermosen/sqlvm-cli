#!/bin/bash
set -e

SHOW_HELP=false
TARGET_DIR="$(pwd)/backups"
DATABASE_NAME=""
PORT=2222
POSITIONAL=()

# Parse flags
while [[ $# -gt 0 ]]; do
    case "$1" in
    --database)
        DATABASE_NAME="$2"
        shift 2
        ;;
    --output)
        TARGET_DIR="$2"
        shift 2
        ;;
    --port)
        PORT="$2"
        shift 2
        ;;
    --help | -h)
        SHOW_HELP=true
        shift
        ;;
    -* | --*)
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
    "$(dirname "$0")/print_help.sh" backup
    exit 0
fi

if [[ -z "$DATABASE_NAME" ]]; then
    echo "You must specify a database name with --database"
    exit 1
fi

TIMESTAMP=$(date +%Y%m%d_%H%M%S)
FILENAME="$DATABASE_NAME-$TIMESTAMP.bak"

mkdir -p "$TARGET_DIR"

echo "Creating backup for '$DATABASE_NAME'..."

ssh -p $PORT algermosen@localhost \
    "/opt/mssql-tools/bin/sqlcmd -S localhost -U sa -P 'YourStrong!Passw0rd' -Q \"BACKUP DATABASE [$DATABASE_NAME] TO DISK = N'/var/opt/mssql/backup/$FILENAME' WITH INIT\""

# Copy backup from VM to host
scp -P $PORT algermosen@localhost:/var/opt/mssql/backup/$FILENAME "$TARGET_DIR/"

echo "Backup saved to $TARGET_DIR/$FILENAME"
