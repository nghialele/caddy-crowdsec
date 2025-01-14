FROM caddy:v2.8.4-builder AS builder

RUN xcaddy build \
    --with github.com/caddy-dns/porkbun \
    --with github.com/mholt/caddy-l4 \
    --with github.com/caddyserver/transform-encoder \
    --with github.com/hslatman/caddy-crowdsec-bouncer/http@main \
    --with github.com/hslatman/caddy-crowdsec-bouncer/layer4@main

FROM caddy:v2.8.4

COPY --from=builder /usr/bin/caddy /usr/bin/caddy
