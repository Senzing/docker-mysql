# mysql

## Overview

1. [Create Docker container](#create-docker-container)
1. [Run Docker container](#run-docker-container)

## Create docker container

### Preparation

The following programs need to be installed:

```console
git --version

docker --version
docker run hello-world
```

Optional:

```console
make --version
```

### Set Environment variables

These variables may be modified, but do not need to be modified.
The variables are used throughout the installation procedure.

```console
export GIT_ACCOUNT=senzing
export GIT_REPOSITORY=mysql
```

Synthesize environment variables.

```console
export GIT_ACCOUNT_DIR=~/${GIT_ACCOUNT}.git
export GIT_REPOSITORY_DIR="${GIT_ACCOUNT_DIR}/${GIT_REPOSITORY}"
export GIT_REPOSITORY_URL="git@github.com:${GIT_ACCOUNT}/${GIT_REPOSITORY}.git"
```

### Clone repository

Get repository.

```console
mkdir --parents ${GIT_ACCOUNT_DIR}
cd  ${GIT_ACCOUNT_DIR}
git clone ${GIT_REPOSITORY_URL}
```

### Build Docker image

Option #1 - Using make command

```console
cd ${GIT_REPOSITORY_DIR}
make docker-build
docker images
```

Option #2 - Using docker command

```console
cd ${GIT_REPOSITORY_DIR}
docker build --tag senzing/mysql .
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
