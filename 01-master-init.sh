#!/bin/bash
# Expects these variables to be set
SLAVE_USER=${SLAVE_USER:-replication}
SLAVE_PASSWORD=${SLAVE_PASSWORD:-replication_pass}

echo Creating replication user ...
mysql -u root -e "\
  GRANT \
    FILE, \
    SELECT, \
    SHOW VIEW, \
    LOCK TABLES, \
    RELOAD, \
    REPLICATION SLAVE, \
    REPLICATION CLIENT \
  ON *.* \
  TO '$SLAVE_USER'@'%' \
  IDENTIFIED BY '$SLAVE_PASSWORD'; \
  FLUSH PRIVILEGES; \
"
