Docker images to support implicit mysql replication support.

Features:
* when you start the slave, it starts with replication set up,
* no manual sync (mysqldump) is needed,
* slave fails to start if replication not healthy

# Start master
```
docker run \
  --name master \
  -v $PWD/master.cnf:/etc/mysql/mysql.conf.d/repl.cnf \
  -v $PWD/01-master-init.sh:/docker-entrypoint-initdb.d/01-master-init.sh \
  -e SLAVE_USER=repl \
  -e SLAVE_PASSWORD=slavepass \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=1 \
  --net host \
  mysql -P 3307
```

# Start slave
```
docker run \
  --name slave \
  -v $PWD/slave.cnf:/etc/mysql/mysql.conf.d/repl.cnf \
  -v $PWD/01-slave-init.sh:/docker-entrypoint-initdb.d/01-slave-init.sh \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=1 \
  -e MASTER_USER=repl \
  -e MASTER_PASSWORD=slavepass \
  -e MASTER_PORT=3307 \
  -e MASTER_HOST=127.0.0.1 \
  --net host \
  mysql -P 3308
```

# Test the replication
```
cat 02-master-database.sql | docker exec -i master mysql
docker exec -it slave mysql -e 'select * from test.names'
```
