class PostgresDb::PgStatStatement < ApplicationRecord
  # connect to the administrative "postgres" database, where the view lives
  establish_connection Rails.configuration.database_configuration['development'].merge({'database' => 'postgres'})

  # gets all statements from stat_statements for the given DB, as an array of hashes
  # @param db_name [String]
  # @return [Array[Hash]]
  def self.statements_for_database(db_name)
    db_oid = PostgresDb::PgStatStatement.find_by_sql("select oid from pg_database where datname='#{db_name}'").first['oid']

    where(dbid: db_oid).as_json
  end
end
