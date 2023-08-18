#!/bin/bash
set -e

SHINY_SERVER_VERSION=${1:-${SHINY_SERVER_VERSION:-latest}}

## build ARGs
NCPUS=${NCPUS:--1}

# a function to install apt packages only if they are not installed
function apt_install() {
    if ! dpkg -s "$@" >/dev/null 2>&1; then
        if [ "$(find /var/lib/apt/lists/* | wc -l)" = "0" ]; then
            apt-get update
        fi
        apt-get install -y --no-install-recommends "$@"
    fi
}


apt_install \
    git \
    xz-utils \
    cmake \
    g++ \
    sudo \
    gcc \
    gdebi-core \
    lsb-release \
    libcurl4-openssl-dev \
    libcairo2-dev \
    libxt-dev \
    xtail \
    wget

# Run dependency scripts
# /rocker_scripts/install_s6init.sh
/rocker_scripts/install_pandoc.sh

# install2.r --error --skipinstalled shiny rmarkdown
