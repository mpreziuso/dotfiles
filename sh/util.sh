# Confirm the correct number of arguments
argument_check() {
  local OPTIND
  while getopts "e:n:f:" OPTION
  do
    case $OPTION in
    e)
      EXPECTED=$OPTARG
      ;;
    n)
      NUMBER=$OPTARG
      ;;
    f)
      FUNCTION=$OPTARG
      ;;
    esac
  done

  if [ $NUMBER -ne $EXPECTED ];  then
    echo "WARNING: incorrect arguments for $FUNCTION" >&2 
    return 1
  fi
  return 0
}

# Ensure the script is being executed by a specific user
ensure_i_am() {
  argument_check -e 1 -n $# -f ensure_i_am

  local OSUSER="${1:-}"
  local WHOAMI
  WHOAMI=$(whoami)

  if [ "$WHOAMI" != "$OSUSER" ]; then
    echo "This script must be run as '${OSUSER}'! You are ${WHOAMI}."
    exit 1
  fi
}
