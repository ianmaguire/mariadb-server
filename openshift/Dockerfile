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
RUN /etc/init.d/mysql start
RUN export CONTAINER_IP=`hostname -i`; mysql -u root -h $CONTAINER_IP -P 3306 -e "SET PASSWORD FOR 'root'@'$CONTAINER_IP' = PASSWORD('$MARIADB_ROOT_PW');"
CMD ["/etc/init.d/mysql restart"]