# Postgres

## Installing via docker

Super simple to do, please do this instead! You can set a docker-compose and docker file to simply import an image which uses docker. Then you can pass environment variables to the container to use database accounts etc. Environment variables should be passed to the docker container via the `--env-file ./path/to/file` command.

## Installing via choco (don't do)

[This link helped me](https://medium.com/@aeadedoyin/getting-started-with-postgresql-on-windows-201906131300-ee75f066df78).

Spews out some garbage of generating a password. I couldn't get it to login
with that at all!

So what I did was after installing postgres, delete everything in the /data
directory that it creates. Then change the permission on the /data folder so
that users can read/write to that directory.

After that, change into the Postgres/\<version>/ directory and run
`pg_ctl init -D ./data` It should say something like:

``` shell
The files belonging to this database system will be owned by user "harve".
```

I then started the postgres database by doing `pg_ctl start -D ./data`.
You can now connect to it via pgAdmin or via psql.

### Creating a user via psql

Once you've done the above steps. You can then connect to the database for
example `psql postgres`. This opens an interactive console which you can do
things like: \1 which shows a list of databases. Template0 and template1 are
template database used when you create a new database.

Now assuming you don't have any other users than the windows user (`\du` to
check) you should create a new superuser:

``` sql
CREATE USER postgres WITH SUPERUSER PASSWORD 'mySuperStrongPass!?1';
```

## Creating a Postgres databse

1. Launch psql
2. Enter account information
3. Enter `CREATE DATABASE my_database`

## Restoring a database from a file

You can load a tar file into a databse by using the **pg_restores** tool.

```shell
pg_restore -U user -d my_database C:\path\to\tar
```

After you put that in, it will prompt for your password.