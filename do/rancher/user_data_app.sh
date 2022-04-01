#!/usr/bin/env bash

set -e

function main {
    update
    package
    install_firewall
    se_linux
    add_repo
    update
    install_docker
    install_docker_compose
    create_dir_work
    create_dir_volume
    download_compose_rancher
    open_ports
}

## Actualizar los paquetes
function update {
    sudo yum update -y
    sudo sleep 30
}

## Instalacion paquetes utiles yum
function package {
    sudo yum install -y yum-utils
    sudo sleep 30
}

## Apertura de puertos con firewalld
function install_firewall {   
    sudo yum install firewalld -y
    sudo systemctl start firewalld
    sudo systemctl enable firewalld
    sudo sleep 30
}

## Selinux
function se_linux {
    sudo setenforce 0
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
    sudo sleep 30
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

## Crear directorio de trabajo
function create_dir_work {
    sudo mkdir /root/rancher
}

## Crear directorio de volumen
function create_dir_volume {
    sudo mkdir /var/jenkins_home
}

## Descargar archivo docker-compose
function download_compose_rancher {
    sudo yum install wget -y
    sudo sleep 10
    sudo wget -P /root/rancher/ https://raw.githubusercontent.com/jsgiraldoh/rancher/main/docker-compose.yml
}

## Abrir los puertos del firewall
function open_ports {
    sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=443/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=2376/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=2379/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=2380/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=6443/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=8472/udp
    sudo firewall-cmd --zone=public --permanent --add-port=9099/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=10250/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=10254/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=30000-32767/tcp
    sudo firewall-cmd --zone=public --permanent --add-port=30000-32767/udp
    sudo firewall-cmd --reload
}

main