ensure_python_is_installed() {
    if is_os_amzn_linux_based; then
        amzn_enable_pkg python3.8
        yum install python38 python38-pip -y
    elif is_os_yum_rpm_based; then
        yum install python3 python3-pip -y
    elif is_os_dnf_rpm_based; then
        dnf install python3 python3-pip -y
    elif is_os_deb_based; then
        apt-get install python3 python3-pip -y
    fi
}
