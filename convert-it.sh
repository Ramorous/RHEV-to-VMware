#!/usr/bin/env bash
# convert-it.sh
#### <image> : Full path to oVirt/RHEV Image File
#### <destination_name> : Name of destination VMDK

# Path of where to save converted VMDK
CONVERT_DIR="/vmware-iso/converts"
# Default QEMU Options
QEMU_OPTIONS="-o compat6"

function usage {
  echo "$0 <image> <destination_name>"
}

if [[ $# -ne 2 ]]; then
  usage
  exit 1
fi

if [[ -e $1 ]]; then
  IMAGE_META=$(grep -Fq 'COW' $1.meta; echo $?)
  case $IMAGE_META in
	0)
	  FORMAT_TYPE="qcow2"
	  QEMU_OPTIONS="-o adapter_type=lsilogic,subformat=streamOptimized,compat6"
	  ;;
	1)
	  FORMAT_TYPE="raw"
	  ;;
	*)
	  echo "Problem determining type from $1.meta"
	  usage
	  exit 1
	  ;;
  esac
  echo "Converting Image Type : $FORMAT_TYPE"
  qemu-img convert -f $FORMAT_TYPE $1 -O vmdk $CONVERT_DIR/$2.vmdk $QEMU_OPTIONS
else
  echo "Image not Found"
  usage
  exit 2
fi
