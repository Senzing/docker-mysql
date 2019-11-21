# docker-mysql

## Overview

This Dockerfile is a wrapper over the [MySQL Command-Line Tool](https://dev.mysql.com/doc/refman/8.0/en/mysql.html).

### Contents

1. [Create Docker container](#create-docker-container)
1. [Docker network](#docker-network)
1. [Run Docker container](#run-docker-container)

### Legend

1. :thinking: - A "thinker" icon means that a little extra thinking may be required.
   Perhaps you'll need to make some choices.
   Perhaps it's an optional step.
1. :pencil2: - A "pencil" icon means that the instructions may need modification before performing.
1. :warning: - A "warning" icon means that something tricky is happening, so pay attention.

## Create docker container

1. Build docker container.
   Example:

    ```console
    sudo docker build \
      --tag senzing/mysql \
      https://github.com/senzing/docker-mysql.git
    ```

## Docker network

:thinking: **Optional:**  Use if docker container is part of a docker network.

1. List docker networks.
   Example:

    ```console
    sudo docker network ls
    ```

1. :pencil2: Specify docker network.
   Choose value from NAME column of `docker network ls`.
   Example:

    ```console
    export SENZING_NETWORK=*nameofthe_network*
    ```

1. Construct parameter for `docker run`.
   Example:

    ```console
    export SENZING_NETWORK_PARAMETER="--net ${SENZING_NETWORK}"
    ```

## Run Docker container

1. :pencil2: Identify the file of SQL to be run.
   Example:  If the actual file pathname is `/path/to/mysqlfile.sql`

    ```console
    export MYSQL_DIR=/path/to
    export MYSQL_FILE=mysqlfile.sql
    ```

1. :pencil2: Identify the database username and password.
   Example:

    ```console
    export MYSQL_USERNAME=root
    export MYSQL_PASSWORD=root
    ```

1. :pencil2: Identify the database that is the target of the SQL statements.
   Example:

    ```console
    export MYSQL_DATABASE=mydatabase
    ```

1. :pencil2: Identify the host running mySQL servers.
   Example:

    ```console
    sudo docker ps

    # Choose value from NAMES column of docker ps
    export MYSQL_HOST=docker-container-name
    ```

1. Create the docker container.
   Note: parameters after senzing/mysql are
   [mysql CLI options](https://dev.mysql.com/doc/refman/5.7/en/mysql-command-options.html).

    ```console
    sudo docker run -it  \
      --volume ${MYSQL_DIR}:/sql \
      ${SENZING_NETWORK_PARAMETER} \
      senzing/mysql \
        --user=${MYSQL_USERNAME} \
        --password=${MYSQL_PASSWORD} \
        --host=${MYSQL_HOST} \
        --database=${MYSQL_DATABASE} \
        --execute="source /sql/${MYSQL_FILE}"
    ```
