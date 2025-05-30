#!/bash/bin

set -e

# 👉 Define defaults here
SHOW_HELP=false
FORCE=false
POSITIONAL=()

# Flag parsing
while [[ $# -gt 0 ]]; do
  case "$1" in
    --force)
      FORCE=true
      shift
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
  "$(dirname "$0")/print_help.sh" down
  exit 0
fi

# Try to get the VM PID
PID=$(pgrep -f "qemu-system-x86_64.*ubuntu.img")

if [[ -z "$PID" ]]; then
  echo "No running SQL VM found."
  exit 0
fi

if $FORCE; then
  echo "Force killing VM with PID $PID"
  kill -9 "$PID"
else
  echo "Gracefully stopping VM with PID $PID"
  kill "$PID"
fi

echo "SQL VM stopped."
