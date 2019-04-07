#!/bin/bash
echo "域名（eg：example.com）:\n"

read NGROK_DOMAIN

openssl genrsa -out cert/rootCA.key 2048

openssl req -x509 -new -nodes -key cert/rootCA.key -subj "/CN=$NGROK_DOMAIN" -days 5000 -out cert/rootCA.pem

openssl genrsa -out cert/device.key 2048

openssl req -new -key cert/device.key -subj "/CN=$NGROK_DOMAIN" -out cert/device.csr

openssl x509 -req -in cert/device.csr -CA cert/rootCA.pem -CAkey cert/rootCA.key -CAcreateserial -out cert/device.crt -days 5000
pwd
echo "y"|cp cert/rootCA.pem assets/client/tls/ngrokroot.crt

echo "y"|cp cert/device.crt assets/server/tls/snakeoil.crt

echo "y"|cp cert/device.key assets/server/tls/snakeoil.key
