#!/bin/bash
set -e

/etc/init.d/mysql/start

mysqladmin -u root password ${MARIADB_ROOT_PW}

exec "$@"