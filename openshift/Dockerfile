FROM registry.access.redhat.com/rhel7

RUN subscription-manager register --org=11787140 --activationkey=MariaDB_Server_Container

COPY mariadb_repo_setup.sh /usr/src/mariadb_repo_setup.sh

RUN yum -y update; yum clean all
RUN bash /usr/src/mariadb_repo_setup.sh
RUN yum install -y mariadb-server

EXPOSE 3306
CMD ["service mariadb start"]
