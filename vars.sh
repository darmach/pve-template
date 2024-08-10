export release="noble"
export imageName="$release-server-cloudimg-amd64.img"
export sourceURL=https://cloud-images.ubuntu.com/$release/current/
export imageURL=$sourceURL$imageName
export md5sumURL=$sourceURL"MD5SUMS"
export templateId="1000"
export templateName="ubuntu-"$( [[ $release = noble ]] && echo 24.04 || echo 22.04 )
export cpus="2"
export memory="2048"
export cpuType="host"
export storagePoolName="local-zfs"
export sshKey=""
