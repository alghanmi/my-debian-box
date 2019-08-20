#!/bin/bash
export PATH=/usr/local/bin:$PATH

if [ -f /var/run/reboot-required ]; then
	echo "Reboot Required since $(stat --format=%z /var/run/reboot-required)" | slacktee -c "alerts"  -a "danger" -t "Reboot Required" --field "Host" "$(hostname)" --field "Host Time" "$(date)"
fi
