#!/bin/bash

FILES="$HOME/.config/envs.d/*"
for f in $FILES
do
  cat $f
done
