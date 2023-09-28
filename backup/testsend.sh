#!/bin/bash
# ==========================================
# Color
RED='\033[0;31m'
NC='\033[0m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHT='\033[0;37m'
# ==========================================
# Getting
arfvpn="/etc/arfvpn"
IP=$(cat $arfvpn/IP)
MYISP=$(cat $arfvpn/ISP)
DOMAIN=$(cat $arfvpn/domain)
email=$(cat /home/email)
date=$(date +"%Y-%m-%d");

echo -e "
This is the content of a test email to send an email from a vps
IP VPS : $IP
Date   : $date
" | mail -s "Email Delivery Trial" $email

echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu 