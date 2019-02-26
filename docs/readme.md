# Configuring PostgreSQL

This app needs Postgres to have the pg_stat_statements extension configured and running:


edit postgresql.conf, add two lines near the beginning:
show config_file;   "/usr/local/var/postgres/postgresql.conf"

shared_preload_libraries = 'pg_stat_statements'
pg_stat_statements.track = all

restart the DB, then:

CREATE EXTENSION pg_stat_statements;

# Seeing and resetting the stats

To see the data, go to DB 'postgres' and execute:

SELECT * FROM pg_stat_statements;

SELECT pg_stat_statements_reset();