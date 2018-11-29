FROM rhel:rhel7

RUN VERSION=`cat version`; bash mariadb_repo_setup.sh; yum install -y mariadb-server-$VERSION

EXPOSE 3306
CMD ["service mariadb start"]
