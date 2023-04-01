#!/bin/bash
 
docker run -it --rm \
  -v "$HOME/.dotfiles":/dotfiles \
  -v $PWD:/cwd \
  -v $HOME/.config:/config:rw \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -w /cwd \
  --network host \
  ghcr.io/ogkevin/userspace "$@"

