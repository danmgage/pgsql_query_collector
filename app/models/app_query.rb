class AppQuery < ApplicationRecord
  has_and_belongs_to_many :branch_test_runs

  # @param pg_stat_statements [Array[Hash]] statements as_json
  # @return [Array[AppQuery]] the queries corresponding to these statements
  def self.map_from_pg_stat_statements(pg_stat_statements)
    app_queries = []

    # we want to save all or none
    transaction do
      pg_stat_statements.each do |statement_row|
        query = where(queryid: statement_row[:queryid]).first_or_create do |r|
          r.query = statement_row[:query]
        end

        raise StandardError.new("query does not match!") if query.query != statement_row[:query]

        app_queries << query
      end
    end

    return app_queries
  end
end
