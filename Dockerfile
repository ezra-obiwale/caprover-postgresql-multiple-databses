FROM library/postgres:9.6-alpine

COPY create-databases.sh /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/create-databases.sh

EXPOSE 5432
