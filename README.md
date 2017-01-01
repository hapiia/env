# env
qemu-system-x86_64 -drive format=raw,file=win020.img -m 4096 -enable-kvm -cpu host -smp 2 -device intel-hda -device hda-duplex -k ja -vga qxl -spice port=5900,disable-ticketing,agent-mouse=off -device virtio-serial,bus=pci.0,addr=0x7 -device spicevmc,subtype=vdagent

