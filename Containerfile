FROM nvidia/cuda:11.8.0-runtime-ubuntu22.04

LABEL com.github.containers.toolbox="true" \
      usage="This image is meant to be used with the toolbox or distrobox command" \
      summary="A cloud-native terminal experience powered by Ubuntu" \
      maintainer="ryanwalker8484@gmail.com"

COPY ./extra-packages /toolbox-packages

RUN apt-get update && \ 
    apt-get upgrade -y && \
    DEBIAN_FRONTEND=noninteractive apt-get -y install \
        $(cat toolbox-packages | xargs) && \
    rm -rd /var/lib/apt/lists/*

RUN rm /toolbox-packages

RUN   ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/docker && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/flatpak && \ 
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/podman && \
      ln -fs /usr/bin/distrobox-host-exec /usr/local/bin/rpm-ostree
