This tool records the queries between two executions of the tests of an application, and
then allows to print the new queries for the second execution.

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
NB: the queryid is NOT stable after a reset, ie, the same query can have a different queryid

# example usage from the console

b1 = Branch.create name: '1114' 

b2 = Branch.create name: '1114_after_test'

branch_comparison = BranchComparison.create


PostgresDb::PgStatStatement.pg_stat_statements_reset()

## run the test on b1

branch_test_run = branch_comparison.collect_branch_queries(b1)

## run the test on b2

branch_test_run_2 = branch_comparison.collect_branch_queries(b2)

## print to screen the new queries
puts branch_comparison.additional_queries_for_branch(b2).join("\n")