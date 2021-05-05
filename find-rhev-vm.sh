#!/usr/bin/env bash
# find-rhev-vm.sh
### <name> : Name to search for

# Path of RHEV/oVirt Disks
RHEV_DIR="/rhev-export/UUID/images"

function usage {
  echo "$0 <NAME>"
  exit 1
}

[[ $# -ne 1 ]] && usage

find $RHEV_DIR -name '*.meta' -exec grep -H "$1" {} \;
