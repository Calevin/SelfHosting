#!/bin/bash
exec >> /home/example/logs/webhook-deployments.log 2>&1

export HOME="/home/example"
export USER="example"

if [ -f "$HOME/.keychain/$HOSTNAME-sh" ]; then
    source "$HOME/.keychain/$HOSTNAME-sh"
fi

cd /home/example/servicios/Blog

git pull origin main

# Reconstruir la imagen y levantar el contenedor
docker compose up -d --build
