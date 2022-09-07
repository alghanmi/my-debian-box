#!/bin/bash
export PATH=/usr/local/bin:$PATH

slacktee --no-output --channel "hosts" --attachment "warning" --title ":email: Email Message" --field "Host" "$(hostname)" --field "Host Time" "$(date)" --field "User" "$USER"
