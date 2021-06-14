yum install nfs-utils
sudo systemctl enable --now nfs-server.service

mkdir -p /srv/nfs/kubedata
chown nobody: /srv/nfs/kubedata

mkfs.ext4 /dev/sdb
mount /dev/sdb /srv/nfs/kubedata

UUID=$(blkid -o udev /dev/sdb | head -1 | cut -f2 -d"=")

echo $UUID" /srv/nfs/kubedata	ext4	defaults	0 0" >> /etc/fstab

echo "/srv/nfs/kubedata       *(rw,sync,no_subtree_check,no_root_squash,no_all_squash,insecure)" >> /etc/exports

exportfs -rav

showmount -e 10.128.0.11
