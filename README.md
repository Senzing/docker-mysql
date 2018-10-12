# docker-mysql

## Overview

This Dockerfile is a wrapper over the [MySQL Command-Line Tool](https://dev.mysql.com/doc/refman/8.0/en/mysql.html).

### Contents

1. [Create Docker container](#create-docker-container)
1. [Run Docker container](#run-docker-container)

## Create docker container

```console
docker build --tag senzing/mysql https://github.com/senzing/docker-mysql.git
```

## Run Docker container

1. Identify the file of SQL to be run.
   Example:  If the actual file pathname is `/path/to/mysqlfile.sql`

    ```console
    export MYSQL_DIR=/path/to
    export MYSQL_FILE=mysqlfile.sql
    ```

1. Identify the database username and password.
   Example:

    ```console
    export MYSQL_USERNAME=root
    export MYSQL_PASSWORD=root
    ```

1. Identify the database that is the target of the SQL statements.
   Example:

    ```console
    export MYSQL_DATABASE=mydatabase
    ```

1. Identify the host running mySQL servers.
   Example:

    ```console
    docker ps

    # Choose value from NAMES column of docker ps
    export MYSQL_HOST=docker-container-name
    ```

1. Identify the Docker network of the mySQL database.
   Example:

    ```console
    docker network ls

    # Choose value from NAME column of docker network ls
    export MYSQL_NETWORK=nameofthe_network
    ```

1. Create the docker container.
   Note: parameters after senzing/mysql are [mysql CLI options](https://dev.mysql.com/doc/refman/5.7/en/mysql-command-options.html).

    ```console
    docker run -it  \
      --volume ${MYSQL_DIR}:/sql \
      --net ${MYSQL_NETWORK} \
      senzing/mysql \
        --user=${MYSQL_USERNAME} \
        --password=${MYSQL_PASSWORD} \
        --host=${MYSQL_HOST} \
        --database=${MYSQL_DATABASE} \
        --execute="source /sql/${MYSQL_FILE}"
    ```
