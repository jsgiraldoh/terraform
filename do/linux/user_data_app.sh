#!/usr/bin/env bash

set -e

function main {
    update
    install_epel_release
}

## Actualizar los paquetes
function update {
    sudo yum update -y
    sudo sleep 5
}

## Instalacion epel-release
function install_epel_release {
    sudo yum install epel-release -y
}

main