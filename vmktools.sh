#!/usr/bin/env sh
# vmktools.sh
### Source Disk Name : Name of the source disk (without VMDK extension)
### Destination : Where to copy the disk to

function usage {
  echo "$0 <source disk name> <destination>"
  exit 1
}

[[ $# -ne 2 ]] && usage

echo "Starting...."
vmkfstools -i $1.vmdk -d thin $2/$1.vmdk
echo "Completed."

echo "chmod...."
chmod 644 $2/$1*.vmdk

echo "sed lsilogic...."
sed -i "s/ide/lsilogic/g" $2/$1.vmdk
