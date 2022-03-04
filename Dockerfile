FROM lightninglabs/lnd:v0.14.2-beta

# Image metadata
# git commit
LABEL org.opencontainers.image.revision="-"
LABEL org.opencontainers.image.source="https://github.com/jkaldon/arm64v8-lnd/tree/master"

RUN apk add --no-cache \
             curl \
             openssl \
             screen \
             bash \
             vim && \
  addgroup -g 1000 lnd && \
  adduser -h /home/lnd -s /sbin/nologin --u 1000 -G lnd -D lnd && \
  mkdir -p /data && \
  chown -R lnd.lnd /data

USER lnd
WORKDIR /home/lnd
COPY resources/* /home/lnd/

RUN ln -s /data/lnd /home/lnd/.lnd

