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
domain=$(cat $arfvpn/domain)
ipvps="/var/lib/arfvpn"

clear
echo start
sleep 0.5
source $ipvps/ipvps.conf
#domain=$IP
systemctl enable xray.service
sudo lsof -t -i tcp:80 -s tcp:listen | sudo xargs kill
cd /root/
wget -O acme.sh https://raw.githubusercontent.com/acmesh-official/acme.sh/master/acme.sh
bash acme.sh --install
rm acme.sh
cd .acme.sh
echo "starting...., Port 80 Akan di Hentikan Saat Proses install Cert"
bash acme.sh --register-account -m arief.prsty@gmail.com
bash acme.sh --issue --standalone -d $domain --force
bash acme.sh --installcert -d $domain --fullchainpath /etc/arfvpn/cert/ca.crt --keypath /etc/arfvpn/cert/ca.key
restart

echo ""
read -n 1 -s -r -p "Press any key to back on menu"
menu 