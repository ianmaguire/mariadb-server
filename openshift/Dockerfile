FROM registry.access.redhat.com/rhel7

EXPOSE 3306
ARG MARIADB_ROOT_PW
ARG MARIADB_HOST_RANGE=localhost

COPY mariadb_repo_setup.sh /usr/src/mariadb_repo_setup.sh

RUN subscription-manager register --org=11787140 --activationkey=MariaDB_Server_Container
RUN bash /usr/src/mariadb_repo_setup.sh
RUN yum -y update
RUN yum clean all
RUN yum install -y hostname
RUN yum install -y mariadb-server
RUN /etc/init.d/mysql start; mysqladmin -h 127.0.0.1 -P 3306 password "$MARIADB_ROOT_PW"; /etc/init.d/mysql restart
CMD ["/etc/init.d/mysql start"]