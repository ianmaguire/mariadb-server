FROM registry.access.redhat.com/rhel7

EXPOSE 3306
ARG MARIADB_ROOT_PW
ARG MARIADB_HOST_RANGE=localhost

COPY mariadb_repo_setup.sh /usr/src/mariadb_repo_setup.sh

RUN subscription-manager register --org=11787140 --activationkey=MariaDB_Server_Container
RUN bash /usr/src/mariadb_repo_setup.sh
RUN yum -y update
RUN yum clean all
RUN yum install -y mariadb-server
RUN systemctl enable mariadb.service
ETRYPOINT /usr/sbin/init &
CMD mysql -e "SET PASSWORD FOR 'root'@'$MARIADB_HOST_RANGE' = PASSWORD('$MARIADB_ROOT_PW');"