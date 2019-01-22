#!/bin/bash
set -eo pipefail
shopt -s nullglob

#sed -i 's/ROOTPASSWORD/$MARIADB_ROOT_PW/g' /etc/my.cnf.d/server.cnf

exec "$@"