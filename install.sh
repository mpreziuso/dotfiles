#!/usr/bin/env bash

main() {
    source sh/all.sh

    # Ensure script is running as root
    ensure_i_am root

    ensure_python_is_installed


    # Ensure ansible is installed
    which ansible > /dev/null && \
        echo "[OK]: Ansible is installed." ||
        ensure_ansible_is_installed
}

main "$@"
