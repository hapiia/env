cd .
cp -rf --parents /var/lib/portage/world .
cp -rf --parents /etc/portage/make.conf .
cp -rf --parents /etc/portage/repos.conf/local.conf .
cp -rf --parents /etc/portage/package.use .
cp -rf --parents /etc/portage/package.keywords .
cp -rf --parents /etc/portage/package.mask .

cp -rf --parents /etc/portage/package.license .

cp -rf --parents /usr/src/linux/.config .
cp -rf --parents /etc/conf.d/modules .

cp -rf --parents /etc/X11/xorg.conf.d/30-keyboard.conf .
cp -rf --parents /etc/conf.d/keymaps .
cp -rf --parents /etc/conf.d/net .

cp -rf --parents /usr/local/portage/* .

cp -rf --parents /etc/init.d/hapii-ats .
