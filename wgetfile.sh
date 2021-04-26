#!/usr/bin/with-contenv bash
# shellcheck shell=bash
##################################
# Copyright (c) 2021,  : MrDoob  #
# Docker owner         : doob187 #
# Docker Maintainer    : doob187 #
# Code owner           : doob187 #
#     All rights reserved        #
##################################
# THIS DOCKER IS UNDER LICENSE   #
# NO CUSTOMIZING IS ALLOWED      #
# NO REBRANDING IS ALLOWED       #
# NO CODE MIRRORING IS ALLOWED   #
##################################
# shellcheck disable=SC2086
# shellcheck disable=SC2006

sudo $(command -v apt) update -yqq && sudo $(command -v apt) upgrade -yqq
if [[ ! -x $(command -v git) ]];then sudo $(command -v apt) install git -yqq;fi
if [[ -d "/opt/installer" ]];then
    sudo $(command -v rm) -rf /opt/installer 
    sudo git clone --quiet https://github.com/doob187/traefikv2installer.git /opt/installer
fi
if [[ ! -d "/opt/installer" ]];then
    sudo git clone --quiet https://github.com/doob187/traefikv2installer.git /opt/installer
fi
cd /opt/installer && $(command -v bash) install.sh
