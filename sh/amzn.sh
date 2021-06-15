amzn_enable_pkg() {
    local package="${1:-}"
    amazon-linux-extras "${package}" enable
}
