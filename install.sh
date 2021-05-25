#!/usr/bin/env bash

main() {
    source sh/all.sh

    # Ensure script is running as root
    ensure_i_am root

    is_os_deb_based && add_apt_repository "http://ppa.launchpad.net/ansible/ansible/ubuntu" "trusty" "93C4A3FD7BB9C367"

    # Ensure ansible is installed
    which ansible > /dev/null && \
        echo "[OK]: Ansible is installed. Please execute playbook." ||
        install ansible
}

main "$@"
