# wireguard-client-generator
A bash script to generate wireguard client configs from the server folder.

## Requisites
In order to work properly, this script needs:
- A working wireguard server.
- To be placed in the same directory that your server config file.
- (optional) qrencode package.
- The server public key must be written in a file (by default looks for server_public.key) in the same directory.

## Configuration
At the beggining of the script you will find some variables with the configuration. You should change, at least, SERVER and PORT.
```bash
SERVER="mydomain.local"
PORT="51820"
NETWORK="10.123.0"
NETMASK="24"
```

## Usage
Once you have met all the requisites and configured the script at your own like, you can execute the script with 2 mandatory arguments:
- ClientName: A string without blank spaces with the name given to your new client.
- last_IP_octet: The last octet of the IP that will be given to your client. Take into account that you can commit a mistake and give the same IP to different clients, because the script doesn't check if the IP already exists (maybe a future feature). By default the script is designed for a /24 network.


So an example of a successful execution would be:


![](sample_execution.png)
