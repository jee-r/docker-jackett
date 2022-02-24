FROM ubuntu:latest

LABEL name="docker-jackett" \
      maintainer="Jee jee@eer.fr" \
      description="jackett is a lightweight, Free Software, cross-platform BitTorrent client." \
      url="https://github.com/Jackett/Jackett" \
      org.label-schema.vcs-url="https://github.com/jee-r/docker-jackett" \
      org.opencontainers.image.source="https://github.com/jee-r/docker-jackett" 

ENV DEBIAN_FRONTEND="noninteractive" \
    XDG_DATA_HOME="/config" \
    XDG_CONFIG_HOME="/config"

COPY rootfs /

RUN apt-get update && \
    apt-get install -y \
      curl \
      tzdata \
      libicu66 \
      libssl1.0 && \
    curl -o /tmp/jackett.tar.gz -L https://github.com/Jackett/Jackett/releases/latest/download/Jackett.Binaries.LinuxAMDx64.tar.gz && \
    tar xf /tmp/jackett.tar.gz -C /opt/ && \
    rm -rf /var/lib/apt/lists/* /tmp/*

EXPOSE 9117
USER jackett
VOLUME ["/config"]
WORKDIR /config

CMD ["/opt/Jackett/jackett", "--NoUpdates"]
