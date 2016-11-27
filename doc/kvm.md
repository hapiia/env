
/usr/src/linux/.config
CONFIG_HAVE_KVM=y
CONFIG_HAVE_KVM_IRQCHIP=y
CONFIG_HAVE_KVM_EVENTFD=y
CONFIG_KVM=y
CONFIG_KVM_GUEST=y
CONFIG_KVM_INTEL=y
CONFIG_VHOST_NET=y

emerge app-emulation/libvirt virt-manager

gpasswd -a tatsuyasen kvm
