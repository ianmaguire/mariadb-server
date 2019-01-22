#!/bin/bash
set -e

sed -i 's/ROOTPASSWORD/${MARIADB_ROOT_PW}/g' /etc/my.cnf.d/server.cnf

exec "$@"