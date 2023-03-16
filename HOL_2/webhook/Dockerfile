FROM ubuntu:focal
WORKDIR /opt
COPY certs/* .
COPY ./bin/mutating-webhook .
CMD ["./mutating-webhook", "--tls-cert", "/etc/opt/server.crt", "--tls-key", "/etc/opt/server.key"]
