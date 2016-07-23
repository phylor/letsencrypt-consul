#!/bin/sh

server=$(hostname -f)

echo "Creating certificates for server $server"
mkdir -p /certificates

IFS=$'\n'
set -f
for name in $(cat "/tmp/containers"); do
    fqdn="$name.$server"

    echo -n "$fqdn"

    if [ ! -f /etc/letsencrypt/live/$fqdn/{fullchain.pem,privkey.pem} ]; then
        echo " creating.."
        certbot auth --non-interactive --text -a standalone --agree-tos --email $EMAIL --standalone-supported-challenges http-01 -d $fqdn && \
        cat /etc/letsencrypt/live/$fqdn/fullchain.pem /etc/letsencrypt/live/$fqdn/privkey.pem > /certificates/$fqdn.pem
    else
        echo " exists"
    fi
done