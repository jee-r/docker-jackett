# docker-jackett
[![Drone (cloud)](https://img.shields.io/drone/build/jee-r/docker-jackett?style=flat-square)](https://cloud.drone.io/jee-r/docker-jackett)
[![Docker Image Size (latest by date)](https://img.shields.io/docker/image-size/j33r/jackett?style=flat-square)](https://microbadger.com/images/j33r/jackett)
[![MicroBadger Layers](https://img.shields.io/microbadger/layers/j33r/jackett?style=flat-square)](https://microbadger.com/images/j33r/jackett)
[![Docker Pulls](https://img.shields.io/docker/pulls/j33r/jackett?style=flat-square)](https://hub.docker.com/r/j33r/jackett)
[![DockerHub](https://img.shields.io/badge/Dockerhub-j33r/jackett-%232496ED?logo=docker&style=flat-square)](https://hub.docker.com/r/j33r/jackett)

A docker image for [Jackett](https://github.com/Jackett/Jackett) ![jackett's logo](https://raw.githubusercontent.com/Jackett/Jackett/master/src/Jackett.Common/Content/apple-touch-icon-57x57.png)

## docker-compose

```
version: '3.8'
services:
  jackett:
    image: j33r/jackett:latest
    container_name: jackett
    init: true
    restart: unless-stopped
    user: 1000:1000
    depends_on:
      - proxy
    ports:
      - 9117:9117
    environment:
      - UMASK_SET=022
      - TZ=Europe/Paris
      - JACKETT_API_KEY="YOUR_JACKETT_API_KEY"
    volumes:
      - ./config:/config
      - ${HOME}/Download:/Download
      - /etc/localtime:/etc/localtime:ro
    command: ["/opt/Jackett/jackett"]
    healthcheck:
      test: ["CMD", "/usr/local/bin/healthcheck.sh"]
      interval: 10s
      timeout: 15s
      #retries: 3
      start_period: 10s
```
