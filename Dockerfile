FROM ubuntu:latest

LABEL name="docker-deluge" \
      maintainer="Jee jee@eer.fr" \
      description="Deluge is a lightweight, Free Software, cross-platform BitTorrent client." \
      url="https://deluge-torrent.org/" \
      org.label-schema.vcs-url="https://github.com/jee-r/docker-deluge"

ENV DEBIAN_FRONTEND="noninteractive" \
    XDG_DATA_HOME="/config" \
    XDG_CONFIG_HOME="/config" \
    uid=1026 \
    gid=65536

RUN apt-get update && \
    apt-get install -y \
      curl \
      tzdata \
      libicu66 \
      libssl1.0 && \
    # Change `users` gid to match the passed in $gid
    sed -i "s/users:x:[0-9]\+:/users:x:$gid:/" /etc/group && \
    useradd --no-create-home -g users -u $uid jackett && \
    mkdir -p /opt/Jackett /config && \
    curl -o /tmp/jacket.tar.gz -L https://github.com/Jackett/Jackett/releases/latest/download/Jackett.Binaries.LinuxAMDx64.tar.gz && \
    tar xf /tmp/jacket.tar.gz -C /opt/Jackett --strip-components=1 && \
    chown -R jackett:users /opt/Jackett /config && \
    rm -rf /var/lib/apt/lists/* /tmp/*

COPY healthcheck.sh /usr/local/bin/healthcheck.sh
EXPOSE 9117
USER jackett
VOLUME ["/config"]
WORKDIR /config

CMD ["/opt/Jackett/jackett", "--NoUpdates"]
