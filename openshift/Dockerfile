FROM registry.access.redhat.com/rhel7

RUN subscription-manager register --org=11787140 --activationkey=MariaDB_Server_Container

COPY version /usr/src/version
COPY mariadb_repo_setup.sh /usr/src/mariadb_repo_setup.sh

RUN yum -y update; yum clean all
RUN export VERSION=`cat /usr/src/version|awk -F "." '{print $1.$2}`; bash /usr/src/mariadb_repo_setup.sh; yum install -y mariadb-server-$VERSION

EXPOSE 3306
CMD ["service mariadb start"]
