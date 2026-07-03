FROM alpine:latest AS downloader

RUN apk --no-cache add \
    wget \
    iputils
WORKDIR /downloads

RUN wget https://github.com/microsoft/edit/releases/download/v2.0.0/edit-2.0.0-x86_64-linux-gnu.tar.gz
RUN tar -xzf edit-2.0.0-x86_64-linux-gnu.tar.gz

FROM debian:trixie-slim

RUN apt-get update && apt-get install -y \
    iputils-ping \
    curl \
    dnsutils \
    && rm -rf /var/lib/apt/lists/*

COPY --from=downloader --chown=1000:1000 ["/downloads/edit","/bin/"]

WORKDIR /data

CMD ["bash"]
