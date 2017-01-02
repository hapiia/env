RUN echo "MAKEOPTS=\"-j8\"" >> /etc/portage/make.conf
RUN echo "GENTOO_MIRRORS=\"ftp://ftp.iij.ad.jp/pub/linux/gentoo/ \
ftp://ftp.jaist.ac.jp/pub/Linux/Gentoo/ \
http://ftp.iij.ad.jp/pub/linux/gentoo/ \
http://ftp.jaist.ac.jp/pub/Linux/Gentoo/ \
rsync://ftp.iij.ad.jp/pub/linux/gentoo/ \
rsync://ftp.jaist.ac.jp/pub/Linux/Gentoo/\"" >> /etc/portage/make.conf

RUN mkdir /etc/portage/package.use
RUN mkdir /etc/portage/package.keywords

RUN echo ">=sys-libs/libseccomp-2.3.0 static-libs" > /etc/portage/package.use/docker
RUN echo "dev-python/ipaddress" > /etc/portage/package.keywords/docker-compose && \
echo "dev-python/cached-property" >> /etc/portage/package.keywords/docker-compose && \
echo "app-emulation/docker-compose" >> /etc/portage/package.keywords/docker-compose && \
echo "dev-python/dockerpty" >> /etc/portage/package.keywords/docker-compose && \
echo "dev-python/websocket-client" >> /etc/portage/package.keywords/docker-compose && \
echo "dev-python/docker-py" >> /etc/portage/package.keywords/docker-compose && \
echo "dev-python/docker-pycreds" >> /etc/portage/package.keywords/docker-compose


RUN echo "CONFIG_BLK_DEV_DM=y" >> /usr/src/linux/.config && \
echo "CONFIG_DM_THIN_PROVISIONING=y" >> /usr/src/linux/.config && \
echo "CONFIG_EXT4_FS=y" >> /usr/src/linux/.config && \
echo "CONFIG_EXT4_FS_POSIX_ACL=y" >> /usr/src/linux/.config && \
echo "CONFIG_EXT4_FS_SECURITY=y" >> /usr/src/linux/.config && \
echo "CONFIG_DEVPTS_MULTIPLE_INSTANCES=y" >> /usr/src/linux/.config && \
echo "CONFIG_CGROUP_DEVICE=y" >> /usr/src/linux/.config && \
echo "CONFIG_MEMCG=y" >> /usr/src/linux/.config && \
echo "CONFIG_MACVLAN=y" >> /usr/src/linux/.config && \
echo "CONFIG_VETH=y" >> /usr/src/linux/.config && \
echo "CONFIG_BRIDGE=y" >> /usr/src/linux/.config && \
echo "CONFIG_BRIDGE_NETFILTER=y" >> /usr/src/linux/.config && \
echo "CONFIG_MEMCG_KMEM=y" >> /usr/src/linux/.config && \
echo "CONFIG_MEMCG_SWAP=y" >> /usr/src/linux/.config && \
echo "CONFIG_MEMCG_SWAP_ENABLED=y" >> /usr/src/linux/.config && \
echo "CONFIG_BLK_CGROUP=y" >> /usr/src/linux/.config && \
echo "CONFIG_CGROUP_PERF=y" >> /usr/src/linux/.config && \
echo "CONFIG_CGROUP_HUGETLB=y" >> /usr/src/linux/.config && \
echo "CONFIG_NET_CLS_CGROUP=y" >> /usr/src/linux/.config && \
echo "CONFIG_CFS_BANDWIDTH=y" >> /usr/src/linux/.config && \
echo "CONFIG_RT_GROUP_SCHED=y" >> /usr/src/linux/.config && \
echo "CONFIG_CGROUP_NET_PRIO=y" >> /usr/src/linux/.config

RUN emerge app-emulation/docker app-emulation/docker-compose
RUN usermod -aG docker tatsuyasen

RUN echo "127.0.0.1       gentoo03" >> /etc/hosts
RUN echo "www-servers/apache apache2_modules_http2 apache2_modules_proxy \
apache2_modules_proxy_http apache2_modules_auth_digest apache2_modules_deflate \
ssl threads" > /etc/portage/package.use/apache
# RUN echo "APACHE2_MODULES=\"proxy\"" >> /etc/portage/make.conf

RUN emerge www-servers/apache

# /etc/conf.d/apache2
# -D AUTH_DIGEST -D HTTP2 -D PROXY

# CONFIG_SYSVIPC=y
# /etc/apache2/httpd.conf

RUN echo "app-crypt/certbot" > /etc/portage/package.keywords/certbot && \
echo "dev-python/pyrfc3339" >> /etc/portage/package.keywords/certbot && \
echo "app-crypt/acme" >> /etc/portage/package.keywords/certbot && \
echo "dev-python/pythondialog" >> /etc/portage/package.keywords/certbot && \
echo "dev-python/parsedatetime" >> /etc/portage/package.keywords/certbot && \
echo "dev-python/zope-component" >> /etc/portage/package.keywords/certbot && \
echo "app-crypt/certbot" >> /etc/portage/package.keywords/certbot

RUN echo "=app-crypt/certbot-9999 **" > /etc/portage/package.keywords/certbot-apache && \
echo "=app-crypt/certbot-apache-9999 **" >> /etc/portage/package.keywords/certbot-apache && \
echo "dev-python/python-augeas" >> /etc/portage/package.keywords/certbot-apache && \
echo "=app-crypt/acme-9999 **" >> /etc/portage/package.keywords/certbot-apache

RUN emerge app-crypt/certbot certbot-apache

firewall-cmd --zone=block --add-port=80/tcp --permanent
firewall-cmd --zone=block --add-port=443/tcp --permanent
firewall-cmd --zone=block --add-port=1988/tcp --permanent
firewall-cmd --reload
RUN certbot --apache certonly
# certbot renew
