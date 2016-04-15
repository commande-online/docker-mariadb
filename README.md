# docker-mariadb
Docker configuration for running the MariaDB service for Commande-Online.fr SAS

## Before using for your own security
Please update the password provided in the Dockerfile file. It should only be used in a DEV env and **NOT IN PRODUCTION OR STAGING**

## Instruction
Simply execute the Dockerfile to build the environment

## Known issues
On windows, mounting a folder for /var/lib/mysql doesn't work
