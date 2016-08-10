Docker images to support implicit mysql replication support.

Features:
* based on official mysql images
* when you start the slave, it starts with replication started,
* no manual sync (mysqldump) is needed,
* slave fails to start if replication not healthy

Additional environment variables:
* REPLICATION_USER [default: replication]
* REPLICATION_PASSWORD [default: replication_pass]
* REPLICATION_HEALTH_GRACE_PERIOD [default: 3]
* REPLICATION_HEALTH_TIMEOUT [default: 10]
* MASTER_PORT [default: 3306]
* MASTER_HOST [default: master]

# Start master

```
docker run -d \
  --name mysql_master \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=1 \
  bergerx/mysql-replication:5.7
```

# Start slave

```
docker run -d \
  --name mysql_slave \
  -e MYSQL_ALLOW_EMPTY_PASSWORD=1 \
  --link mysql_master:master \
  bergerx/mysql-replication:5.7
```

# Test the replication
```
cat 02-master-database.sql | docker exec -i mysql_master mysql
docker exec -it mysql_slave mysql -e 'select * from test.names'
```
