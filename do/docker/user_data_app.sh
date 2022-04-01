#!/usr/bin/env bash

set -e

function main {
    update
    add_repo
    update
    install_docker
    install_docker_compose
}

## Actualizar los paquetes
function update {
    sudo yum update -y
    sudo sleep 10
}

## Agregar el repositorio oficial a los archivos de yum.repos.d
function add_repo {
    sudo yum-config-manager \
    --add-repo \
    https://download.docker.com/linux/centos/docker-ce.repo
}

## Agregar el repositorio de docker a los repositorios disponibles
function update {
    sudo yum update -y
    sudo sleep 10
}

## Instalacion docker
## Iniciar el servicio de docker
## Habilitar el servicio de docker persistente a reinicios
## Verificar la version de docker
function install_docker {
    sudo yum install docker-ce docker-ce-cli containerd.io -y
    sudo systemctl start docker
    sudo systemctl enable docker
    sudo docker --version
}

## Descargar docker-compose
## Otorgar permisos de ejecucion al binario de docker-compose
## Crear un link simbolico al binario de docker-compose
## Verificar la version de docker-compose
function install_docker_compose {
    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
    sudo chmod +x /usr/local/bin/docker-compose
    sudo ln -s /usr/local/bin/docker-compose /usr/bin/docker-compose
    sudo docker-compose --version
}

main