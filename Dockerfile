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
  chown -R lnd.lnd /data && \
  cd /tmp && \
  wget https://github.com/LN-Zap/lndconnect/releases/download/v0.2.0/lndconnect-linux-arm64-v0.2.0.tar.gz && \
  tar -xzf lndconnect-linux-arm64-v0.2.0.tar.gz && \
  mv lndconnect-linux-arm64-v0.2.0/lndconnect /usr/local/bin/ && \
  rm -rf lndconnect-linux-arm64-v0.2.0.tar.gz lndconnect-linux-arm64-v0.2.0/

USER lnd
WORKDIR /home/lnd
COPY resources/* /home/lnd/

RUN ln -s /data/lnd /home/lnd/.lnd

