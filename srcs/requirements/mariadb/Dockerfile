FROM debian:buster

ARG DB_ROOT
ARG DB_PASS_ROOT
ARG DB_USER
ARG DB_PASS_USER
ARG DB_NAME

RUN apt update

RUN apt install mariadb-server mariadb-client procps -y

RUN mkdir -p /var/lib/mysql /var/run/mysqld && \
	chown -R mysql:mysql /var/lib/mysql /var/run/mysqld && \
	chmod 777 /var/run/mysqld

RUN echo "\n[mariadb]\nbind-address=0.0.0.0\nport=3306\n" >>/etc/mysql/my.cnf

COPY tools /tmp/

RUN chmod a+x /tmp/setup.sh

RUN /tmp/setup.sh

EXPOSE 3306

ENTRYPOINT ["mysqld_safe"]