FROM alpine

RUN apk add --no-cache \
	nginx \
	nginx-mod-http-headers-more \
        nginx-mod-http-brotli \
        supervisor \
	npm

RUN mkdir /srv/http

RUN install -d -o nginx -g nginx \
            /var/log/nginx \
            /var/log/supervisor

COPY overlay /

WORKDIR /srv/http

EXPOSE 80

HEALTHCHECK --interval=5m --timeout=3s CMD curl --fail http://localhost:80 || exit 1

CMD ["supervisord", "-n", "-c", "/etc/supervisord.conf"]

