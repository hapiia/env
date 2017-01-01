RUN echo "MAKEOPTS=\"-j8\"" >> /etc/portage/make.conf
RUN echo "GENTOO_MIRRORS=\"ftp://ftp.iij.ad.jp/pub/linux/gentoo/ \
ftp://ftp.jaist.ac.jp/pub/Linux/Gentoo/ \
http://ftp.iij.ad.jp/pub/linux/gentoo/ \
http://ftp.jaist.ac.jp/pub/Linux/Gentoo/ \
rsync://ftp.iij.ad.jp/pub/linux/gentoo/ \
rsync://ftp.jaist.ac.jp/pub/Linux/Gentoo/\"" >> /etc/portage/make.conf

RUN echo "www-servers/apache apache2_modules_http2 ssl threads" > /etc/portage/package.use/apache

RUN emerge www-servers/apache

# /etc/conf.d/apache2

# /etc/apache2/httpd.conf

RUN mkdir /etc/portage/package.keywords
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



<IfDefine SSL>
<IfDefine SSL_DEFAULT_VHOST>
<IfModule ssl_module>
Listen 443
KeepAlive On
HostnameLookups Off
<VirtualHost _default_:443>
  ServerName hapii.baunter.com
  Protocols h2 http/1.1
  WSGIDaemonProcess hapii2 user=vpsuser group=vpsuser processes=1 threads=5
        WSGIScriptAlias / /home/vpsuser/baunterPlatform/src/index.wsgi
        DocumentRoot "/home/vpsuser/baunterPlatform"

        Alias /static "/home/vpsuser/baunterPlatform/src/static/"
        <Directory /home/vpsuser/baunterPlatform/src/static>
          Require all granted
        </Directory>

        <Directory /home/vpsuser/baunterPlatform>
                WSGIProcessGroup hapii2
                WSGIApplicationGroup %{GLOBAL}
                #Order deny,allow
                #Allow from all
                #AllowOverride All
                AuthType Digest
                AuthName "test"
                AuthDigestProvider file
                AuthUserFile /home/vpsuser/baunterPlatform/digestpass
                Require valid-user
