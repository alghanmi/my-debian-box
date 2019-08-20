#!/bin/bash
export PATH=/usr/local/bin:$PATH
echo "$(last -x reboot)" | slacktee --no-output --channel "alerts"  --attachment "warning" --title "Reboot Alert" --field "Host" "$(hostname)" --field "Host Time" "$(date)"
