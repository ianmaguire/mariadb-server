#!/bin/bash
set -eo pipefail

dir="$(dirname "$(readlink -f "$BASH_SOURCE")")"

image="$1"

export MARIADB_ROOT_PASSWORD='mdb-root-password'
export MARIADB_USER='mdb-user'
export MARIADB_PASSWORD='mdb-password'
export MARIADB_DATABASE='mdb-database'

mdb="mysql --user=$MARIADB_USER --password=$MARIADB_PASSWORD $MARIADB_DATABASE"

docker run -d --name $image -e MARIADB_ROOT_PASSWORD -e MARIADB_USER -e MARIADB_PASSWORD -e MARIADB_DATABASE $image bash

mysql() {
	docker exec -d $image "$mdb -e $@"
}

echo 'CREATE TABLE test (a INT, b INT, c VARCHAR(255))' | mysql
[ "$(echo 'SELECT COUNT(*) FROM test' | mysql)" = 0 ]
echo 'INSERT INTO test VALUES (1, 2, "hello")' | mysql
[ "$(echo 'SELECT COUNT(*) FROM test' | mysql)" = 1 ]
echo 'INSERT INTO test VALUES (2, 3, "goodbye!")' | mysql
[ "$(echo 'SELECT COUNT(*) FROM test' | mysql)" = 2 ]
echo 'DELETE FROM test WHERE a = 1' | mysql
[ "$(echo 'SELECT COUNT(*) FROM test' | mysql)" = 1 ]
[ "$(echo 'SELECT c FROM test' | mysql)" = 'goodbye!' ]
echo 'DROP TABLE test' | mysql

