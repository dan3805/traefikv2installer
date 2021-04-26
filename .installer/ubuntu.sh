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
appstartup() {
if [[ $EUID -ne 0 ]];then
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⛔  You must execute as a SUDO user (with sudo) or as ROOT!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
exit 0
fi
while true; do
  $(command -v apt) update -yqq && $(command -v apt) upgrade -yqq
  if [[ ! -x $(command -v git) ]];then sudo $(command -v apt) install git -yqq;fi
  if [[ -d "/opt/traefik " ]];then $(command -v rm) -rf /opt/traefik;fi
  if [[ ! -d "/opt/traefik" ]];then cd /opt/ && git clone --quiet https://github.com/doob187/Traefikv2.git /opt/traefik;fi
  if [[ -d "/opt/apps" ]];then $(command -v rm) -rf /opt/apps;fi
  if [[ ! -d "/opt/apps" ]];then cd /opt/ && git clone --quiet https://github.com/doob187/traefikv2apps.git /opt/apps;fi
  clear && headinterface
done
}
traefik() {
cd /opt/traefik && $(command -v bash) install.sh
}
traefikapp() {
cd /opt/apps && $(command -v bash) install.sh
}
headinterface() {
tee <<-EOF
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    🚀 Traefik V2 Head Installer [ EASY MODE ]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

    [ 1 ] Traefik V2 - TraefikV2 + Authelia
    [ 2 ] Traefik V2 - Apps

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
    [ EXIT or Z ] - Exit
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
EOF
  read -erp "↘️  Type Number and Press [ENTER]: " headsection </dev/tty
  case $headsection in
    1) clear && traefik ;;
    2) clear && traefikapp ;;
    #help|HELP|Help) clear && sectionhelplayout ;;
    Z|z|exit|EXIT|Exit|close) exit ;;
    *) clear && appstartup ;;
  esac
}
##########
appstartup