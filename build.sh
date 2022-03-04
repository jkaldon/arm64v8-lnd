#!/bin/sh
set -ex
DOCKER_TAG=v0.14.2-beta-5

docker build --progress plain -t "jkaldon/arm64v8-lnd:${DOCKER_TAG}" .
docker push "jkaldon/arm64v8-lnd:${DOCKER_TAG}"
