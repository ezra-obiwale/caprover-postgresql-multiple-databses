ARG POSTGRES_VERSION=latest

FROM postgres:${POSTGRES_VERSION}

COPY create-databases.sh /docker-entrypoint-initdb.d/

RUN chmod +x /docker-entrypoint-initdb.d/create-databases.sh

EXPOSE 5432
