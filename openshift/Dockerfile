FROM registry.access.redhat.com/rhel7

EXPOSE 3306

COPY mariadb_repo_setup.sh /usr/src/mariadb_repo_setup.sh
COPY server.cnf /etc/my.cnf.d/server.cnf
COPY entrypoint.sh /usr/local/bin/entrypoint.sh

RUN subscription-manager register --org=11787140 --activationkey=MariaDB_Server_Container
RUN bash /usr/src/mariadb_repo_setup.sh
RUN yum -y update
RUN yum clean all
RUN yum install -y hostname
RUN yum install -y mariadb-server
ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
CMD ["/etc/init.d/mysql start"]