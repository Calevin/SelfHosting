# SelfHosting
My self-hosting configurations

## Configure Cloudflare Tunnel on Ubuntu 24.04

1. After installing cloudflared -> authenticate:
```cloudflared login```
File ~/.cloudflared/cert.pem created

2. Create cloudflared tunnel:
```cloudflared tunnel create example-server-tunnel```
File ~/.cloudflared/xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.json created

3. Create /etc/cloudflared
```sudo mkdir /etc/cloudflared```

4. Copy .json to /etc/cloudflared
```cp .cloudflared/xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.json /etc/cloudflared/xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.json```

5. Create /etc/cloudflared/config.yml
```sudo nano /etc/cloudflared/config.yml```

```
# /etc/cloudflared/config.yml

# El UUID del túnel
tunnel: xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
# Ruta al archivo de credenciales de tu túnel
credentials-file: /etc/cloudflared/xxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx.json

# Reglas de entrada: cómo se enruta el tráfico
# Cloudflare gestionará HTTPS para estos hostnames públicos.
# El 'service' apunta a donde Caddy está escuchando localmente (HTTP).
ingress:
  # Regla para Portainer
  - hostname: portainer.example.com
    service: http://localhost:80
  - hostname: debug-tunnel.example.com
    service: http://localhost:80
  #- hostname: hello.example.com
  #  service: http://localhost:8080

  # Se puedes añadir más servicios aquí. Por ejemplo:
  # - hostname: blog.example.com
  #   service: http://localhost:80
  # - hostname: miapi.example.com
  #   service: http://localhost:80

  # Esto devuelve un error 404 para cualquier tráfico dirigido al túnel
  # que no coincida con un hostname configurado arriba.
  - service: http_status:404
```

6. Generate CNAME DNS record
```cloudflared tunnel route dns example-server-tunnel portainer.example.com```

7. Install, start, enable cloudflared service
```
cloudflared service install
systemctl start cloudflared
systemctl enable cloudflared
```

## Links
[How to Configure Cloudflare Tunnel on Ubuntu 24.04](https://www.linuxtuto.com/how-to-configure-cloudflare-tunnel-on-ubuntu-24-04/)
