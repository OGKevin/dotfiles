# You can find the new timestamped tags here: https://hub.docker.com/r/gitpod/workspace-full/tags
FROM gitpod/workspace-full
MAINTAINER Kevin Hellemun
LABEL maintainer="Kevin Hellemun"
LABEL org.opencontainers.image.source=https://github.com/OGKevin/dotfiles

ARG dotfiles=dotfiles.git
ARG vcsprovider=github.com
ARG vcsowner=OGKevin

COPY ./ $HOME/.dotfiles/

RUN \
     sudo chown -R gitpod:gitpod $HOME/.dotfiles && \
     cd $HOME/.dotfiles && \
     git remote set-url origin git@${vcsprovider}:${vcsowner}/${dotfiles}

RUN \
    cd $HOME/.dotfiles && \
    ./install-profile gitpod

