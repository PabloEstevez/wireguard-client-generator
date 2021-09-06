#!/bin/bash

# Colors
RED='\033[0;31m'
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

# Input checks
if [ $# -ne 2 ]; then printf "${RED}[-]${NC} Usage: $0 ClientName last_IP_octet\n" && exit;fi
[ -d "./$1" ] && printf "${RED}[-]${NC} The client ${CYAN}$1${NC} already exists\n" && exit

# Configuration
SERVER="mydomain.local"
PORT="51820"
NETWORK="10.123.0"
NETMASK="24"

mkdir $1
# Generate client private/public keys
wg genkey | tee $1/private.key | wg pubkey | tee $1/public.key &> /dev/null

# Client config file
cat <<EOT >> $1/wg_$1.conf
[Interface]
Address = $NETWORK.$2/$NETMASK
DNS = $NETWORK.1, 8.8.8.8 # Change this if your server doesn't have DNS service
PrivateKey = $(cat $1/private.key)

[Peer]
PublicKey = $(cat server_public.key)
AllowedIPs = 0.0.0.0/0
Endpoint = $SERVER:$PORT
PersistentKeepalive = 25
EOT

# Server config
cat <<EOT >> wg0.conf

$(echo "# $1")
[Peer]
PublicKey = $(cat $1/public.key)
AllowedIPs = $NETWORK.$2/32
EOT

printf "Client ${RED}$1${NC} successfully created!\n"

printf "\n${GREEN}[+]${NC} Config file: ${CYAN}$(pwd)/$1/wg_$1.conf${NC}\n\n"
if command -v qrencode &> /dev/null
then
  qrencode -r $1/wg_$1.conf -t UTF8
fi
echo ""
