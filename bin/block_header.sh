#!/usr/bin/env bash
# Generate shell script header block
IFS=$'\n'

figlet -f slant "${1:0:14}" | boxes -d pound-cmt && echo -ne "#\n# $1\n# $2"