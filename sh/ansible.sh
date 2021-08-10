ansible_galaxy_install_collections() {
    local file="${1:-}"
    ansible-galaxy collection install -r "${file}" -p .
}
