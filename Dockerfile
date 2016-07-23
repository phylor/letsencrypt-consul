FROM quay.io/letsencrypt/letsencrypt:latest

RUN apt-get update && apt-get install -y unzip

ENV CONSUL_TEMPLATE_VERSION 0.12.2

ADD https://releases.hashicorp.com/consul-template/${CONSUL_TEMPLATE_VERSION}/consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip /

WORKDIR /

RUN unzip consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mv consul-template /usr/local/bin/consul-template &&\
    rm -rf /consul-template_${CONSUL_TEMPLATE_VERSION}_linux_amd64.zip && \
    mkdir -p /consul-template /consul-template/config.d /consul-template/templates

ADD templates/containers.ctmpl /consul-template/templates/

ENTRYPOINT []
CMD /usr/local/bin/consul-template -consul $CONSUL_CONNECT -template '/consul-template/templates/containers.ctmpl:/tmp/containers:sh /tmp/containers'
