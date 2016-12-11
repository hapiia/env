cd .
cp -rf --parents /var/lib/portage/world .
cp -rf --parents /etc/portage/make.conf .
cp -rf --parents /etc/portage/repos.conf/local.conf .
cp -rf --parents /etc/portage/package.use .
cp -rf --parents /etc/portage/package.keywords/ .
cp -rf --parents /etc/portage/package.mask/ .

cp -rf --parents /etc/portage/package.license .

cp -rf --parents /usr/src/linux/.config .

cp -rf --parents /usr/local/portage/* .
