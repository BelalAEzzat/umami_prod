CREATE USER backupuser WITH PASSWORD 'backuppassword';
ALTER USER backupuser WITH REPLICATION, LOGIN;