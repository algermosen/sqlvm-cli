#!/bash/bin

set -e

# 👉 Define defaults here
SHOW_HELP=false
HEADLESS=false
MEMORY=4096
CPUS=2
POSITIONAL=()

# Parse flags
while [[ $# -gt 0 ]]; do
  case "$1" in
    --headless)
      HEADLESS=true
      shift
      ;;
    --memory)
      MEMORY="$2"
      shift 2
      ;;
    --cpus)
      CPUS="$2"
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
  "$(dirname "$0")/print_help.sh" up
  exit 0
fi

QEMU_ARGS=(
  -m "$MEMORY"
  -smp "$CPUS"
  -cpu host
  -boot c
  -drive file=ubuntu.img,format=qcow2
  -net nic -net user,hostfwd=tcp::2222-:22
)

if $HEADLESS; then
  QEMU_ARGS+=( -nographic )
else
  QEMU_ARGS+=( -display default,show-cursor=on )
fi

echo "Starting SQL VM..."
qemu-system-x86_64 "${QEMU_ARGS[@]}"
