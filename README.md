# RHEV-to-VMware
oVirt/RHEV Disks to VMware Conversion

## Story
I've had the pleasure of having to convert our RHEV environment to VMware. With lack of documentation and VMware Converter no longer being supported I took my *nix expertise to do this. I scoured the interwebs and pieced together a few things. What I wasn't aware of is that RHEV stores the disks in both RAW and QCOW2. Raw is for preallocated disks and QCOW2 is for thin provisioned.

So to preface this, you'll need to first have either a VM or container running your favorite flavour of *nix. I chose CentOS in a container. I also chose to run this on a Synology we have in the office so that I could set it up as both the export domain, and NFS datastore to make moving files easier.

## Requirements

Export Domain in RHEV/oVirt

*nix system with qemu-img installed

SSH enabled ESXi host (for vmkfstools)

## Optional

tmux (helps when trying to run multiple tasks at once)

## How To

Without further ramblings, here are the steps...

1. Within RHEV/oVirt
1.1 Export VM
1.2 Check Storage->Disks for UUID of VM disks
**** Alternatively, you can run the command below to see them from your *nix Container
2. *nix VM/Container, Convert Script Below (not in a git repo yet, sorry)
3. Within ESXi shell, run the vmkfstools script below (or manually of course). This will convert it to a proper VMDK and copy it to its final destination. If you don't copy it with this, then you'll need to move it yourself. It will also convert adapter type to lsilogic as well as set proper permissions of the destination file.
