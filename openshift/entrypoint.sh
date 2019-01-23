#!/bin/bash
set -e

/etc/init.d/mysql start


if [[ -n $MARIADB_ROOT_PW ]]
then
	mysqladmin -u root password $MARIADB_ROOT_PW
fi

#/etc/init.d/mysql restart

exec "$@"