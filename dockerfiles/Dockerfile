FROM alpine:latest
MAINTAINER Kevin Hellemun
LABEL maintainer="Kevin Hellemun"
LABEL org.opencontainers.image.source=https://github.com/OGKevin/dotfiles

ARG user=ogkevin
ARG group=wheel
ARG uid=1000
ARG dotfiles=dotfiles.git
ARG userspace=dotfiles.git
ARG vcsprovider=github.com
ARG vcsowner=OGKevin

USER root

RUN \
    echo "https://dl-cdn.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories && \
    apk upgrade --no-cache && \
    apk add --update --no-cache \
        sudo \
        autoconf \
        automake \
        libtool \
        nasm \
        ncurses \
        ca-certificates \
        libressl \
        bash-completion \
        cmake \
        ctags \
        file \
        curl \
        build-base \
        gcc \
        coreutils \
        wget \
        neovim \
        git git-doc \
        zsh \
        docker \
        docker-compose


RUN \
    echo "%${group} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    adduser -D -G ${group} ${user} && \
    addgroup ${user} docker

COPY ./ /home/${user}/.dotfiles/
RUN \
     git config --global --add safe.directory /home/${user}/.dotfiles && \
     chown -R ${user}:${group} /home/${user}/.dotfiles && \
     cd /home/${user}/.dotfiles && \
     git remote set-url origin git@${vcsprovider}:${vcsowner}/${dotfiles}

USER ${user}
RUN \
    cd $HOME/.dotfiles && \
    ./install-profile userspace


ENV HISTFILE=/config/.history
WORKDIR /home/${user}

CMD []
