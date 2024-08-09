#!/bin/bash
# Fail on error
set -e
# Source customized vars
source ./vars.sh

# Pull and verify the image integrity
curl $imageURL -o $imageName
curl $md5sumURL -o $imageName.md5
md5sum -c $imageName.md5 --ignore-missing

# These images are missing quest agent
virt-customize -a $imageName --install qemu-guest-agent

# VM creation
# Creates a VM defining amount of cores, ram, and setting type of the CPU
# Quemu guest agent support is enabled, OS type set to linux, BIOS to UEFI
# Virtio network to be connected to the bridge and using DHCP
qm create $templateId --name $templateName --cores $cpus --memory $memory --cpu cputype=$cpuTypeRequired \
--agent enabled=1 --ostype l26 --bios ovmf --net0 virtio,bridge=vmbr0 --ipconfig0 ip=dhcp
# Adding EFI drive required for UEFI boot support
qm set $templateId --efidisk0 $volumeName:0
# Adding cloud-init drive because cloud-init
qm set $templateId --ide2 $volumeName:cloudinit
# Image import
qm importdisk $templateId $imageName $volumeName
# Boot drive set to VIRTIO SCSI Single (supposedly optimum nowadays) with writeback cache and guaranteed io thread
qm set $templateId --scsihw virtio-scsi-single --scsi0 $storagePoolName:vm-$templateId-disk-1,cache=writeback,iothread=1
qm set $templateId --boot c --bootdisk scsi0
# Convert it to VM template
qm template $templateId
