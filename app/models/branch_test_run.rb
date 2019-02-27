class BranchTestRun < ApplicationRecord
  has_and_belongs_to_many :app_queries

  belongs_to :branch
  belongs_to :branch_comparison

  # collect queries from the target DB and populates the Queries table
  # @param db_name [String]
  # @return [Array[AppQuery]] all the queries found in the stats table
  def collect_queries(db_name)
    # find the queries
    found_queries = AppQuery.map_from_pg_stat_statements(PostgresDb::PgStatStatement.statements_for_database(db_name))

    # associate them
    found_queries.each do |query|
      app_queries << query
    end

    return found_queries
  end
end
