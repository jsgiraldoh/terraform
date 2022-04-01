#!/usr/bin/env bash

set -e

function main {
    update
    install_haproxy
}

## Actualizar los paquetes
function update {
    sudo yum update -y
    sudo sleep 5
}

## Instalacion haproxy
function install_haproxy {
    sudo yum install haproxy -y
    sudo sleep 5
    sudo systemctl start haproxy
    sudo systemctl enable haproxy
}

main