FROM registry.access.redhat.com/rhel7

ARG MARIADB_ROOT_PW

RUN subscription-manager register --org=11787140 --activationkey=MariaDB_Server_Container

COPY mariadb_repo_setup.sh /usr/src/mariadb_repo_setup.sh

RUN yum -y update; yum clean all
RUN bash /usr/src/mariadb_repo_setup.sh
RUN yum install -y mariadb-server

EXPOSE 3306
RUN service mariadb start

CMD mysql -e "SET PASSWORD FOR 'root'@'%' = PASSWORD('$MARIADB_ROOT_PW');"