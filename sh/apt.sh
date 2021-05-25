#-------------------
# Add APT repository
#-------------------
add_apt_repository() {
  argument_check -e 3 -n $# -f add_apt_repository 

  local REPO_URL="${1:-}"
  local CHANNEL="${2:-}"
  local GPG_KEY_ID="${3:-}"

  echo "deb ${REPO_URL} ${CHANNEL} main" | sudo tee -a /etc/apt/sources.list

  apt-key adv --keyserver keyserver.ubuntu.com --recv-keys ${GPG_KEY_ID}
}
