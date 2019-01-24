FROM registry.access.redhat.com/rhel7

EXPOSE 3306

COPY mariadb_repo_setup.sh /usr/src/mariadb_repo_setup.sh

RUN mkdir -p /etc/mysql/
RUN mkdir /docker-entrypoint-initdb.d
RUN subscription-manager register --org=11787140 --activationkey=MariaDB_Server_Container
RUN bash /usr/src/mariadb_repo_setup.sh
RUN yum -y update
RUN yum clean all
RUN yum install -y hostname
RUN yum install -y mariadb-server

COPY entrypoint.sh /usr/local/bin/entrypoint.sh

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

CMD ["/etc/init.d/mysql start"]