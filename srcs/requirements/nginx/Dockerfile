FROM debian:buster

ARG DOMAIN_NAME

RUN apt update

RUN apt install openssl -y

RUN openssl req -x509 -nodes -days 365 -subj \
	"/C=BR/ST=PR/O=42/CN=$DOMAIN_NAME" -addext \
	"subjectAltName=DNS:$DOMAIN_NAME" -newkey rsa:2048 \
	-keyout /etc/ssl/private/nginx-selfsigned.key -out \
	/etc/ssl/certs/nginx-selfsigned.crt

RUN apt install nginx -y

COPY conf /etc/nginx/sites-available

RUN ln -s /etc/nginx/sites-available/rkenji-s.42.fr /etc/nginx/sites-enabled/

EXPOSE 443

ENTRYPOINT ["nginx", "-g", "daemon off;"]