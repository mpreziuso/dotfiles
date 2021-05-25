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

# Install via package manger
install() {
    argument_check -e 1 -n $# -f install

    local PACKAGE_NAME="${1:-}"

    if is_os_dnf_rpm_based; then
        dnf install ${PACKAGE_NAME} -y
    elif is_os_yum_rpm_based; then
        yum install ${PACKAGE_NAME} -y
    elif is_os_deb_based; then
        apt-get update && apt-get install ${PACKAGE_NAME} -y
    else
        echo "Unsupported OS. Please install Ansible before proceeding. Not that you have much choice... =)"
        exit 1
    fi
}

get_os_name() {
    grep '^NAME' /etc/os-release | cut -d= -f 2 | tr -d '"'
}

is_os_dnf_rpm_based() {
    local OS_NAME
    OS_NAME=$(get_os_name)

    if [ "${OS_NAME}" = "Fedora" ]; then
        return 0
    fi

    return 1
}

is_os_yum_rpm_based() {
    local OS_NAME
    OS_NAME=$(get_os_name)

    if [ "${OS_NAME}" = "Amazon Linux" ] || 
       [ "${OS_NAME}" = "CentOS" ] ||
       [ "${OS_NAME}" = "RedHat" ]; then
        return 0
    fi

    return 1
}

is_os_deb_based() {
    local OS_NAME
    OS_NAME=$(get_os_name)

    if [ "${OS_NAME}" = "Raspbian GNU/Linux" ] ||
         [ "${OS_NAME}" = "Ubuntu" ]; then
        return 0
    fi
    return 1
}

