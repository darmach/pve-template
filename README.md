# Bash script creating a UEFI booted cloud-init ready Proxmox VM template from scratch.

Supports Ubuntu for now, by default uses a Noble image, and templates a q35 type VM using `host` cpu and booted with UEFI bios, Qemu guest agent installed and ssh public key added - either user provided one or generated.

Usage:
1. Customize vars file as required. Defaults are highly opinionated ;)
2. Unless you add your ssh public key it will be generated. Public key  can either be added as a String in vars (i.e. shorter ed25519 key), or you can just drop it into work directory named `authorizedKey.pub`
