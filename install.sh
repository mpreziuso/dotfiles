#!/usr/bin/env bash

main() {
    source sh/all.sh

    # Ensure script is running as root
    ensure_i_am root

    # Ensure ansible is installed
    which ansible > /dev/null || install ansible && \
        echo "[OK]: Ansible is installed. Please execute playbook."
}

main "$@"
