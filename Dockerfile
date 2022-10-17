ARG base=alpine
FROM ${base}

RUN set -ex; \
apk add --no-cache python3 py3-flask apache2-mod-wsgi apache2-http2 dumb-init; \
mv /etc/apache2/conf.d/wsgi-module.conf /etc/apache2/conf.d/http2.conf /tmp/; \
rm /etc/apache2/conf.d/*; \
mv /tmp/wsgi-module.conf /etc/apache2/conf.d/00-wsgi-module.conf; \
mv /tmp/http2.conf /etc/apache2/conf.d/00-http2.conf; \
# HTTP/2 requires mpm_event instead of mpm_prefork
sed -i 's|^\(LoadModule mpm_prefork_module\)|#\1|' /etc/apache2/httpd.conf; \
sed -i 's|^#\(LoadModule mpm_event_module\)|\1|' /etc/apache2/httpd.conf; \
# Log to stdout/stderr
sed -i 's#^ErrorLog .*#ErrorLog /dev/stderr#' /etc/apache2/httpd.conf; \
sed -i 's#logs/access.log#/dev/stdout#' /etc/apache2/httpd.conf; \
mkdir -p /app/media; \
echo 'example asset' > /app/media/example.txt

COPY app.py /app/app.py
COPY wsgi-app.conf /etc/apache2/conf.d/99-app.conf
ENTRYPOINT ["/usr/bin/dumb-init", "--", "/bin/sh", "-exc"]

ENV LOGLEVEL=info
CMD ["exec /usr/sbin/httpd -D FOREGROUND -e $LOGLEVEL"]
