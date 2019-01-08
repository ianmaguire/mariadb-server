FROM registry.access.redhat.com/rhel7

RUN subscription-manager register --org=11787140 --activationkey=MariaDB_Server_Container

COPY version /usr/src/version
COPY mariadb_repo_setup.sh /usr/src/mariadb_repo_setup.sh

RUN yum -y update; yum clean all
RUN VERSION=`cat /usr/src/version`; bash /usr/src/mariadb_repo_setup.sh; yum install -y mariadb-server

# RUN VERSION=`cat /usr/src/version`; curl downloads.mariadb.com/MariaDB/mariadb-$VERSION/yum/rhel7-amd64/rpms/MariaDB-$VERSION-centos73-x86_64-server.rpm --output /usr/src/MariaDB-$VERSION-centos73-x86_64-server.rpm; rpm -i /usr/src/MariaDB-$VERSION-centos73-x86_64-server.rpm

EXPOSE 3306
CMD ["/etc/init.d/mysql start"]
