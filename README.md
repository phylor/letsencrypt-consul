# Letsencrypt for Consul

- External requests from letsencrypt need to be proxied to the port specified in the mapping


    docker run \
        -e CONSUL_CONNECT=localhost:8500 \
        -e FQDN=example.com \
        -e EMAIL=admin@example.com \
        -v /home/user/ssl:/certificates \
        -v /home/user/letsencrypt:/etc/letsencrypt \
        -p 127.0.0.1:9999:80
        -d \
        phylor/letsencrypt-consul