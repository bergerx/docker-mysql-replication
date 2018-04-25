FROM mysql:8.0
ENV REPLICATION_USER replication
ENV REPLICATION_PASSWORD replication_pass
COPY replication-entrypoint.sh /usr/local/bin/
COPY init-slave.sh /
ENTRYPOINT ["replication-entrypoint.sh"]
CMD ["mysqld"]
