# Using multiple databases with the official PostgreSQL Docker image

The [official recommendation](https://hub.docker.com/_/postgres/) for creating
multiple databases is as follows:

*If you would like to do additional initialization in an image derived from
this one, add one or more `*.sql`, `*.sql.gz`, or `*.sh` scripts under
`/docker-entrypoint-initdb.d` (creating the directory if necessary). After the
entrypoint calls `initdb` to create the default `postgres` user and database,
it will run any `*.sql` files and source any `*.sh` scripts found in that
directory to do further initialization before starting the service.*

This directory contains a script to create multiple databases using that
mechanism.

## Usage

The usage is the same as the [official image](https://hub.docker.com/_/postgres/) with the addition of 2 environment variables.

### POSTGRES_VERSION

This indicates the version of the postgres image you want to download. Default is `latest`.

### POSTGRES_DATABASES

This is where you specify the multiple databases required. The format is `USER:PASSWORD@DATABASE` separated by semi-colons (`;`).

## Examples

In both examples below, 2 databases are created with different users and passwords. You are however not limited to 2 databases. You can create as many as required.

### Run an instance

```bash
docker run -e POSTGRES_PASSWORD=mysecurepassword -e POSTGRES_DATABASES="user1:password1@database1;user2:password2@database2" ezraobiwale/postgres-multidb
```

### Docker Compose

    postgres:
        image: ezraobiwale/postgres-multidb:latest
        environment:
            - POSTGRES_PASSWORD=mysecurepassword
            - POSTGRES_DATABASES="user1:password1@database1; user2:password2@database2"
