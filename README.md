# docker-jackett

## docker-compose

```
version: '3.7'
services:
  jackett:
    #build: ./
    image: j33r/jackett:latest
    container_name: jackett
    init: true
    restart: unless-stopped
    #depends_on:
    #  - sshuttle
    #network_mode: "service:sshuttle"
    networks:
      - default
    environment:
      - TZ=Europe/Paris
      - JACKETT_API_KEY="YOUR_JACKETT_API_KEY"
    volumes:
      - ./config:/config
      - /torrents:/torrents
      - /etc/localtime:/etc/localtime:ro
    ports:
      - 9117:9117
    command: ["/opt/Jackett/jackett"]
    healthcheck:
      test: ["CMD", "/usr/local/bin/healthcheck.sh"]
      interval: 10s
      timeout: 15s
      #retries: 3
      start_period: 10s
```
