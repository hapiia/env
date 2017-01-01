#!/usr/bin/env bash

ipaddr=160.16.207.32
netmask=255.255.254.0
broadcast=160.16.207.255
gateway=160.16.206.1
devicepath=/dev/vda

if [ $# -eq 1 ]; then
 devicepath="$1"
fi

source /etc/profile && export PS1="(chroot) $PS1"

emerge-webrsync

#eselect profile set 2

echo "Asia/Tokyo" > /etc/timezone
emerge --config sys-libs/timezone-data

echo "en_US.UTF-8 UTF-8" > /etc/locale.gen && locale-gen

# eselect locale list
eselect locale set 1

env-update && source /etc/profile

# echo GRUB_PLATFORMS="efi-64" >> /etc/portage/make.conf
echo MAKEOPTS="-j3" >> /etc/portage/make.conf

emerge --autounmask-write sys-kernel/gentoo-sources sys-apps/pciutils vim dev-python/pip app-admin/sysklogd sys-boot/grub:2 net-misc/dhcpcd app-admin/ansible
# dispatch-conf < u
dispatch-conf
emerge sys-kernel/gentoo-sources sys-apps/pciutils vim dev-python/pip app-admin/sysklogd firewalld sys-boot/grub:2 net-misc/dhcpcd


cd /usr/src/linux

make defconfig

cat << EOF >> /usr/src/linux/.config
# KVM support
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM=y
CONFIG_KVM_GUEST=y
CONFIG_KVM_INTEL=y
CONFIG_VHOST_NET=y

CONFIG_USB_HID=y
CONFIG_USB_XHCI_HCD=y

CONFIG_VIRTIO_BLK=y
CONFIG_VIRTIO_PCI=y
CONFIG_VIRTIO_NET=y
CONFIG_PARAVIRT=y


CONFIG_VMWARE_VMCI=y
CONFIG_HYPERVISOR_GUEST=y
CONFIG_VSOCKETS=y
CONFIG_VMESRE_VMCI_VSOCKETS=y
CONFIG_VMWARE_BALLOON=y
CONFIG_SCSI_LOWLEVEL=y
CONFIG_VMWARE_PVSCSI=y
CONFIG_FUSION=y
CONFIG_FUSION_SPI=y
CONFIG_FUSION_MAX_SGE=128

CONFIG_VMXNET3=y
CONFIG_I2C_PIIX4=y
CONFIG_DRM_TTM=y
CONFIG_DRM_VMWGFX=y
CONFIG_FB_DEPERRED_IO=y

EOF

make && make modules_install && make install

echo "config_eth0=\"${ipaddr} netmask ${netmask} brd ${broadcast}\"" >> /etc/conf.d/net
echo "routes_eth0=\"default via ${gateway}\"" >> /etc/conf.d/net
echo "nameserver 210.188.224.10" >> /etc/resolv.conf
echo "nameserver 210.188.224.11" >> /etc/resolv.conf

# echo "config_eth0=\"dhcp\"" > /etc/conf.d/net
cd /etc/init.d && ln -s net.lo net.eth0

wget --no-check-certificate https://github.com/hapiia/env/raw/master/gentoo03/service.yml
wget --no-check-certificate https://github.com/hapiia/env/raw/master/gentoo03/hostname.yml
wget --no-check-certificate https://github.com/hapiia/env/raw/master/gentoo03/fstab.yml

pip install ansible
ansible-playbook service.yml --connection=local
ansible-playbook hostname.yml --connection=local
ansible-playbook fstab.yml --extra-vars "two=${devicepath}2 three=${devicepath}3 four=${devicepath}4" --connection=local

grub-install ${devicepath}
# grub2-install --target=x86_64-efi --efi-directory=/boot
grub-mkconfig -o /boot/grub/grub.cfg

# useradd -m -G users,wheel,audio,video,usb -s /bin/bash username
# passwd username

# setting rootpassword
passwd
