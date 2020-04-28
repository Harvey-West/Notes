# Postgres

## Installing via docker

Remember you can pass environment variables to the container
to use database accounts etc.
Environment variables should be passed to the docker container via the
`--env-file ./path/to/file`
command.

There are snipets which are useful and can be viewed as files at
C:\Users\harve\OneDrive\Documents\OneDrive-Work\Snippets\Database\MySQL

### Docker-Compose

``` docker
version: '3'
services:
    db:
        build: .
        image: harveywest/mysql-db
        env_file: ./.env.list
        ports:
            - "3306:3306"
        volumes:
            - C:\Users\harve\C-Work\volumes\mysql:/var/lib/mysql
```

### Dockerfile

``` docker
FROM mysql
EXPOSE 3306
USER mysql
RUN chown -R mysql:mysql /var/lib/mysql
# Add the content of the sql-scripts/ directory to your image
# All scripts in docker-entrypoint-initdb.d/ are automatically
# executed during container startup
# COPY ./sql-scripts/ /docker-entrypoint-initdb.d/
# VOLUME ["/var/lib/mysql"]
```

### ENV file

``` env
MYSQL_USER=mysqlDBO
MYSQL_PASSWORD=mysqlDBO
MYSQL_ROOT_PASSWORD=mysqlROOT
MYSQL_DATABASE=InitialDatabase
```