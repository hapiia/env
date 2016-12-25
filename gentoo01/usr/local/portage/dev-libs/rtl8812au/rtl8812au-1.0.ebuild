# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

# XXX: the tarball here is just the kernel modules split out of the binary
#      package that comes from virtualbox-bin

EAPI=6

inherit eutils linux-mod user git-r3

MY_P=rtl8212au-${PV}
DESCRIPTION="Kernel Modules for Virtualbox"
HOMEPAGE="http://www.virtualbox.org/"
SRC_URI="https://github.com/gnab/rtl8812au/archive/master.tar.gz -> ${P}.tar.gz"

# EGIT_REPO_URI="https://github.com/gnab/rtl8812au.git"
# EGIT_CHECKOUT_DIR="${WORKDIR}/${P}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="pax_kernel"

# RDEPEND="!=app-emulation/virtualbox-9999"

S="${WORKDIR}/rtl8812au-master"

BUILD_TARGETS="all"
BUILD_TARGET_ARCH="${ARCH}"
# MODULE_NAMES="vboxdrv(misc:${S}) vboxnetflt(misc:${S}) vboxnetadp(misc:${S}) vboxpci(misc:${S})"

MODULE_NAMES="8812au("kernel/drivers/net/wireless":${S}:${S})"

pkg_setup() {
	# enewgroup vboxusers

	# CONFIG_CHECK="!TRIM_UNUSED_KSYMS"
	# ERROR_TRIM_UNUSED_KSYMS="The kernel option CONFIG_TRIM_UNUSED_KSYMS removed kernel symbols that are needed by ${PN} to load correctly."

	linux-mod_pkg_setup

	# BUILD_PARAMS="KERN_DIR=${KV_DIR} KERNOUT=${KV_OUT_DIR} V=1 KBUILD_VERBOSE=1"
}
src_unpack(){
  # git-r3_src_unpack
  # git-r3_fetch
  default
}
src_prepare() {
	# if kernel_is -ge 2 6 33 ; then
		# evil patch for new kernels - header moved
	#	grep -lR linux/autoconf.h *  | xargs sed -i -e 's:<linux/autoconf.h>:<generated/autoconf.h>:'
	#fi

	# if use pax_kernel && kernel_is -ge 3 0 0 ; then
	#	epatch "${FILESDIR}"/${PN}-4.1.4-pax-const.patch
	# fi

	default
}

src_install() {
    einfo "Installing ${modulename} module" cd ${objdir} || die "${objdir} does not exist" insinto /lib/modules/${KV_FULL}/${libdir} doins ${modulename}.${KV_OBJ} || die "doins ${modulename}.${KV_OBJ} failed"
    linux-mod_src_compile
	linux-mod_src_install
	# insinto /usr/lib/modules-load.d/
	# doins "${FILESDIR}"/virtualbox.conf
}

pkg_postinst() {
	linux-mod_pkg_postinst
	# elog "If you are using sys-apps/openrc, please add \"vboxdrv\", \"vboxnetflt\","
	# elog "\"vboxnetadp\" and \"vboxpci\" to:"
	# elog "  /etc/conf.d/modules"
}
