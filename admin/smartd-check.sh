#!/bin/bash

## smartd-check.sh
#
# Verifies that all /dev/disk/by-id/ata-* disks
# are configured in /etc/smartd.conf
#

set -ue

all_present=1
disk_count=0

for disk in $(ls -U1 "/dev/disk/by-id" | grep "ata-" | grep -v "part"); do
  disk_count=$((disk_count + 1))
  if ! grep -q "$disk" /etc/smartd.conf; then
    echo "Device not present in smartd.conf: $disk"
    all_present=0
  fi
done

if [ "$all_present" -eq 1 ]; then
  echo "All $disk_count disks present in smartd.conf"
fi
