#!/usr/bin/env zsh

JAR="$HOME/dev/eclipse/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/plugins/org.eclipse.equinox.launcher_*.jar"

java \
    -Declipse.application=org.eclipse.jdt.ls.core.id1 \
    -Dosgi.bundles.defaultStartLevel=4 \
    -Declipse.product=org.eclipse.jdt.ls.core.product \
    -Dlog.protocol=true \
    -Dlog.level=ALL \
    -Xms1g \
    -Xmx2G \
    -jar "${JAR}" \
    -configuration "${HOME}/dev/eclipse/eclipse.jdt.ls/org.eclipse.jdt.ls.product/target/repository/config_linux" \
    -data "${1:-$HOME/workspace}" \
    --add-modules=ALL-SYSTEM \
    --add-opens java.base/java.util=ALL-UNNAMED \
    --add-opens java.base/java.lang=ALL-UNNAMED
