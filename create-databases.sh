#!/bin/bash

set -e
set -u

function create_user_and_database() {
	local credentials=$(echo $1 | tr '@' ' ' | awk  '{print $1}')
	local database=$(echo $1 | tr '@' ' ' | awk  '{print $2}')
	local owner=$(echo $credentials | tr ':' ' ' | awk  '{print $1}')
	local password=$(echo $credentials | tr ':' ' ' | awk  '{print $2}')

	echo "  Creating user '$owner' with password '$password' and database '$database'"
	psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" <<-EOSQL
	    CREATE DATABASE $database;
	    CREATE USER $owner WITH ENCRYPTED PASSWORD '$password' IF NOT EXISTS;
	    GRANT ALL PRIVILEGES ON DATABASE $database TO $owner;
EOSQL
}

if [ -n "$POSTGRES_DATABASES" ]; then
	echo "Creating databases"

	for db in $(echo $POSTGRES_DATABASES | tr ';' ' '); do
		create_user_and_database $db
	done

	echo "Created multiple databases"
else
	echo "Nothing to do"
fi

export POSTGRES_DATABASES='"ownerOfDB1":"passwordOfDB1"@"DB1"; "ownerOfDB2":"passwordOfDB2"@"DB2"; "'