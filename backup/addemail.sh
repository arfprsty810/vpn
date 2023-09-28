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
MYIP=$(cat $arfvpn/IP)
MYISP=$(cat $arfvpn/ISP)
DOMAIN=$(cat $arfvpn/domain)

clear
rm -rf /home/email
echo "Please enter your email"
read -rp "Email : " -e email
cat <<EOF>>/home/email
$email
EOF
clear
echo -e "Backup will send to $email"

echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu 