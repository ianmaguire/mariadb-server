#!/bin/bash
set -e

# Link /etc/mysql/mariadb.conf.d/ to /etc/my.cnf.d/
ln -s /etc/my.cnf.d /etc/mysql/mariadb.conf.d

# if command starts with an option, prepend mysqld
if [ "${1:0:1}" = '-' ]; then
	mysqld "$@"
else
	/etc/init.d/mysql start
fi

if [[ -n $MYSQL_INITDB_SKIP_TZINFO ]]; then
	mysql_tzinfo_to_sql /usr/share/zoneinfo | mysql -u root mysql
fi

if [[ -n $MARIADB_DATABASE ]]; then
	echo "CREATE DATABASE IF NOT EXISTS \`$MARIADB_DATABASE\` ;" | mysql -u root
fi

if [ "$MARIADB_USER" -a "$MARIADB_PASSWORD" ]; then
	echo "CREATE USER '$MARIADB_USER'@'%' IDENTIFIED BY '$MARIADB_PASSWORD' ;" | mysql -u root

	if [ "$MARIADB_DATABASE" ]; then
		echo "GRANT ALL ON \`$MARIADB_DATABASE\`.* TO '$MARIADB_USER'@'%' ;" | mysql -u root
	fi
fi

if [[ -n $MARIADB_ROOT_HOST ]]; then
	echo "CREATE USER 'root'@'${MARIADB_ROOT_HOST}' IDENTIFIED BY '${MARIADB_ROOT_PASSWORD}' ;" | mysql -u root
	echo "GRANT ALL ON *.* TO 'root'@'${MARIADB_ROOT_HOST}' WITH GRANT OPTION ;" | mysql -u root
	echo "FLUSH PRIVILEGES ;" | mysql -u root
fi

if [[ -n $MARIADB_RANDOM_ROOT_PASSWORD ]]; then
	export MARIADB_ROOT_PASSWORD="$(pwgen -1 32)"
	echo "GENERATED ROOT PASSWORD: $MARIADB_ROOT_PASSWORD"
fi

if [[ -n $MARIADB_ROOT_PASSWORD ]]; then
	mysqladmin -u root password $MARIADB_ROOT_PASSWORD
fi

for f in /docker-entrypoint-initdb.d/*; do
	case "$f" in
		*.sh)     echo "$0: running $f"; . "$f" ;;
		*.sql)    echo "$0: running $f"; "${mysql[@]}" < "$f"; echo ;;
		*.sql.gz) echo "$0: running $f"; gunzip -c "$f" | "${mysql[@]}"; echo ;;
		*)        echo "$0: ignoring $f" ;;
	esac
	echo
done

exec "$@"