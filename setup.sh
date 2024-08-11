#!/bin/bash

# Welcome Screen
display_banner () {
banner="__     _____ ____ _____ ____   _____   __  ____  _____ ____ ____  _____ _____ 
\ \   / /_ _/ ___| ____|  _ \ / _ \ \ / / |  _ \| ____/ ___|  _ \| ____| ____|
 \ \ / / | | |   |  _| | |_) | | | \ V /  | | | |  _|| |   | |_) |  _| |  _|  
  \ V /  | | |___| |___|  _ <| |_| || |   | |_| | |__| |___|  _ <| |___| |___ 
   \_/  |___\____|_____|_| \_\\___/ |_|    |____/|_____\____|_| \_\_____|_____|"

echo -e "$banner\n"
}

# Verify Root Context
verify_user_context () {
    if [ "$EUID" -ne 0 ]; then
        echo -e "This script requires the utility of packages that assume root privileges. Please run as root or use sudo.\n"
        exit 1
    fi
}

# Install Dependencies
install_dependencies () {
    packages=(
        ca-certificates
        curl
        git
    )
    apt update
    for package in "${packages[@]}"; do
        echo "Installing $package..."
        apt install -y "$package"
    done
    install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
    chmod a+r /etc/apt/keyrings/docker.asc
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt-get update

    dependencies=(
        docker-ce
        docker-ce-cli
        containerd.io
        docker-buildx-plugin
        docker-compose-plugin
    )
    for dependency in "${dependencies[@]}"; do
        echo "Installing $dependency..."
        apt install -y "$dependency"
    done
}

# Install core CTFd infrastructure
fetch_core_ctfd () {
    git clone https://github.com/CTFd/CTFd.git
}

# Install CTFd plugins
fetch_ctfd_plugins () {
    git clone https://github.com/YWxleGlz/CTFd-Plugins.git
    mv CTFd-Plugins/CTFd-Unique_flags CTFd/plugins/unique_flags
    git clone https://github.com/Bigyls/CTFdDockerContainersPlugin.git CTFd/plugins/containers
}

deploy_ctfd () {
    cd CTFd
    sudo docker build -t dockerfiles/Dockerfile .
    docker compose up
}

display_banner
verify_user_context
install_dependencies
fetch_core_ctfd
fetch_ctfd_plugins
deploy_ctfd

# Command to run in Docker container is /usr/sbin/sshd -D (this will execute the ssh server and keep it running in the foreground indefinitely)