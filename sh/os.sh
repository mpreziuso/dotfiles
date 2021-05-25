# Get OS Name via os-release
get_os_name() {
    grep '^NAME' /etc/os-release | cut -d= -f 2 | tr -d '"'
}

# Is this Fedora
is_os_dnf_rpm_based() {
    local OS_NAME
    OS_NAME=$(get_os_name)

    if [ "${OS_NAME}" = "Fedora" ]; then
        return 0
    fi

    return 1
}

# Is this an RPM based distro
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

# Is this a DEB based distro
is_os_deb_based() {
    local OS_NAME
    OS_NAME=$(get_os_name)

    if [ "${OS_NAME}" = "Raspbian GNU/Linux" ] ||
         [ "${OS_NAME}" = "Ubuntu" ]; then
        return 0
    fi
    return 1
}
