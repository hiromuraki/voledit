FROM alpine:latest AS downloader

RUN apk --no-cache add wget
WORKDIR /downloads

RUN wget https://github.com/microsoft/edit/releases/download/v2.0.0/edit-2.0.0-x86_64-linux-gnu.tar.gz
RUN tar -xzf edit-2.0.0-x86_64-linux-gnu.tar.gz

FROM debian:trixie-slim

COPY --from=downloader --chown=1000:1000 ["/downloads/edit","/bin/"]

WORKDIR /data

CMD ["bash"]
