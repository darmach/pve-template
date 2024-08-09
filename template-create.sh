#!/bin/bash
# source customized vars
source ./vars.sh

curl $imageURL -o $imageName

# These images are missing quest agent
virt-customize -a $imageName --install qemu-guest-agent

# VM creation
qm create $templateId --name $templateName --cores $cpus --memory $memory --cpu cputype=$cpuTypeRequired \
--agent enabled=1 --ostype l26 --bios ovmf --net0 virtio,bridge=vmbr0 --ipconfig0 ip=dhcp
qm set $templateId --efidisk0 $volumeName:0
qm set $templateId --ide2 $volumeName:cloudinit
qm importdisk $templateId $imageName $volumeName
qm set $templateId --scsihw virtio-scsi-single --scsi0 $storagePoolName:vm-$templateId-disk-1,cache=writeback,iothread=1
qm set $templateId --boot c --bootdisk scsi0
qm template $templateId
