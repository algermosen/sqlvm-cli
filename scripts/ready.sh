#!/bin/bash
set -e

SHOW_HELP=false
PORT=1433
HOST="127.0.0.1"
POSITIONAL=()

while [[ $# -gt 0 ]]; do
  case "$1" in
    --host)
      HOST="$2"
      shift 2
      ;;
    --port)
      PORT="$2"
      shift 2
      ;;
    --help|-h)
      SHOW_HELP=true
      shift
      ;;
    -*|--*)
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
  "$(dirname "$0")/print_help.sh" ready
  exit 0
fi

# Try TCP connection using nc (netcat)
echo "Checking if SQL VM is ready at $HOST:$PORT..."

if nc -z "$HOST" "$PORT"; then
  echo "SQL Server is accepting connections on $HOST:$PORT"
  exit 0
else
  echo "SQL Server is not reachable at $HOST:$PORT"
  exit 1
fi
