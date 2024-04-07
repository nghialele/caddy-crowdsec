# caddy-porkbun-crowdsec

[Caddy Docker image](https://hub.docker.com/_/caddy) with the following modules included:
* https://github.com/mholt/caddy-l4
* https://github.com/caddyserver/transform-encoder
* https://github.com/hslatman/caddy-crowdsec-bouncer
* https://github.com/caddy-dns/porkbun

## Why?
Forked from [https://github.com/encg/caddy-cloudflare-crowdsec](https://github.com/encg/caddy-cloudflare-crowdsec) for personal use.
The contents below is from the original repo. I will edit to my version along the way.
## Usage
#### docker-compose.yml
```
version: "3.8"
services:
  caddy:
    image: encg/caddy-cloudflare-crowdsec
    restart: unless-stopped
    ports:
      - "80:80"
      - "443:443"
      - "443:443/udp"
    volumes:
      - $PWD/Caddyfile:/etc/caddy/Caddyfile
      - caddy_data:/data
      - caddy_config/config

volumes:
  caddy_data:
    external: true
  caddy_config:
```

#### .env
```
CF_API_TOKEN=cloudflare_api_token
CS_LOCAL_API_KEY=crowdsec_local_api_key
```

#### Caddyfile
```
{
	acme_dns cloudflare {$CF_API_TOKEN}
	crowdsec {
		api_url http://crowdsec:8080
		api_key {$CS_LOCAL_API_KEY}
		ticker_interval 15s
		#disable_streaming
		#enable_hard_fails
	}
}
```

Refer to the respective projects for further documentation:
* [caddy](https://hub.docker.com/_/caddy)
* https://github.com/hslatman/caddy-crowdsec-bouncer/#usage
* https://github.com/caddy-dns/cloudflare
