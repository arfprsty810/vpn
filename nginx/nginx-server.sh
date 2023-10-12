#!/bin/bash
#########################################################
# Export Color
BIBlack='\033[1;90m'      # Black
BIRed='\033[1;91m'        # Red
BIGreen='\033[1;92m'      # Green
BIYellow='\033[1;93m'     # Yellow
BIBlue='\033[1;94m'       # Blue
BIPurple='\033[1;95m'     # Purple
BICyan='\033[1;96m'       # Cyan
BIWhite='\033[1;97m'      # White
UWhite='\033[4;37m'       # White
On_IPurple='\033[0;105m'  #
On_IRed='\033[0;101m'
IBlack='\033[0;90m'       # Black
IRed='\033[0;91m'         # Red
IGreen='\033[0;92m'       # Green
IYellow='\033[0;93m'      # Yellow
IBlue='\033[0;94m'        # Blue
IPurple='\033[0;95m'      # Purple
ICyan='\033[0;96m'        # Cyan
IWhite='\033[0;97m'       # White
BINC='\e[0m'

RED='\033[0;31m'      # RED 1
RED2='\e[1;31m'       # RED 2
GREEN='\033[0;32m'   # GREEN 1
GREEN2='\e[1;32m'    # GREEN 2
STABILO='\e[32;1m'    # STABILO
ORANGE='\033[0;33m' # ORANGE
PURPLE='\033[0;35m'  # PURPLE
BLUE='\033[0;34m'     # BLUE 1
TYBLUE='\e[1;36m'     # BLUE 2
CYAN='\033[0;36m'     # CYAN
LIGHT='\033[0;37m'    # LIGHT
NC='\033[0m'           # NC

bl='\e[36;1m'
rd='\e[31;1m'
mg='\e[0;95m'
blu='\e[34m'
op='\e[35m'
or='\033[1;33m'
color1='\e[031;1m'
color2='\e[34;1m'
green_mix() { echo -e "\\033[32;1m${*}\\033[0m"; }
red_mix() { echo -e "\\033[31;1m${*}\\033[0m"; }

# Export Align
BOLD="\e[1m"
WARNING="${RED}\e[5m"
UNDERLINE="\e[4m"

# Export Banner Status Information
EROR="[${RED} EROR ${NC}]"
INFO="[${LIGHT} INFO ${NC}]"
OK="[${LIGHT} OK ! ${NC}]"
CEKLIST="[${LIGHT}✔${NC}]"
PENDING="[${YELLOW} PENDING ${NC}]"
SEND="[${GREEN} SEND ${NC}]"
RECEIVE="[${YELLOW} RECEIVE ${NC}]"

#########################################################
arfvpn_bar () {
comando[0]="$1"
comando[1]="$2"
 (
[[ -e $HOME/fim ]] && rm $HOME/fim
${comando[0]} -y > /dev/null 2>&1
${comando[1]} -y > /dev/null 2>&1
touch $HOME/fim
 ) > /dev/null 2>&1 &
 tput civis
# Start
echo -ne "     ${ORANGE}Processing ${NC}${LIGHT}- [${NC}"
while true; do
   for((i=0; i<18; i++)); do
   echo -ne "${TYBLUE}>${NC}"
   sleep 0.1s
   done
   [[ -e $HOME/fim ]] && rm $HOME/fim && break
   echo -e "${LIGHT}]${NC}"
   sleep 1s
   tput cuu1
   tput dl1
   # Finish
   echo -ne "           ${ORANGE}Done ${NC}${LIGHT}- [${NC}"
done
echo -e "${LIGHT}] -${NC}${LIGHT} OK !${NC}"
tput cnorm
}

#########################################################
cd /root
source /etc/os-release
arfvpn="/etc/arfvpn"
nginx="/etc/nginx"
arfvps="/home/arfvps/public_html"
github="raw.githubusercontent.com/arfprsty810/vpn/main"
domain=$(cat ${arfvpn}/domain)
DOMAIN2="s/domainxxx/${domain}/g";
IP=$(cat ${arfvpn}/IP)
MYIP2="s/ipxxx/${IP}/g";
phpv=$(cat /root/phpversion)
clear

#########################################################
echo -e " ${LIGHT}- ${NC}Installing Nginx Server"
arfvpn_bar 'installing_nginx'
echo -e ""
sleep 2

installing_nginx () {
systemctl stop nginx
cd ${nginx}
rm ${nginx}/nginx.conf
wget -O ${nginx}/nginx.conf "https://${github}/nginx/nginx.conf"
rm ${nginx}/sites-enabled/*
rm ${nginx}/sites-available/*
wget -O ${nginx}/sites-available/${domain}.conf "https://${github}/nginx/arfvps.conf"
#sed -i 's/443/8443/g' ${nginx}/sites-available/${domain}.conf
sed -i "${MYIP2}" ${nginx}/sites-available/${domain}.conf
sed -i "${DOMAIN2}" ${nginx}/sites-available/${domain}.conf
sudo ln -s ${nginx}/sites-available/${domain}.conf ${nginx}/sites-enabled
}

#########################################################
user_root () {
useradd -m arfvps;
mkdir -p ${arfvps}/
cd ${arfvps}/
wget -O ${arfvps}/index.html "https://${github}/nginx/index.html"
echo "<?php phpinfo() ?>" > ${arfvps}/info.php
chown -R www-data:www-data ${arfvps}
chmod -R g+rw ${arfvps}
chmod +x /home/
chmod +x /home/arfvps/  
chmod +x ${arfvps}/
}
echo -e " ${LIGHT}- ${NC}Create Root user"
arfvpn_bar 'user_root'
echo -e ""
sleep 2

#########################################################
php_v () {
cd
ls /etc/php > phpversion
sed -i "s/listen = \/run\/php\/php${phpv}-fpm.sock/listen = 127.0.0.1:9000/g" /etc/php/${phpv}/fpm/pool.d/www.conf
rm /root/phpversion
}
echo -e " ${LIGHT}- ${NC}Set PHP-FPM"
arfvpn_bar 'php_v'
echo -e ""
sleep 2

#########################################################
echo -e " ${LIGHT}- ${NC}Make a SSL CERT"
sleep 2
wget -O /usr/bin/cert "https://${github}/cert/cert.sh"
chmod +x /usr/bin/cert
sed -i -e 's/\r$//' /usr/bin/cert
/usr/bin/cert