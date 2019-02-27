class AppQuery < ApplicationRecord
  has_and_belongs_to_many :branch_test_runs

  validates_presence_of :query
  validates_presence_of :queryid

  # @param pg_stat_statements [Array[Hash]] statements as_json
  # @return [Array[AppQuery]] the queries corresponding to these statements
  def self.map_from_pg_stat_statements(pg_stat_statements)
    app_queries = []

    # we want to save all or none
    transaction do
      pg_stat_statements.each do |statement_row|
        query = where(queryid: statement_row['queryid']).first_or_create do |r|
          r.query = statement_row['query']
        end

        if query.query != statement_row['query']
          # raise StandardError.new("query does not match!")

          Rails.logger.warn "Queries do not match! #{statement_row['queryid']}"

          Rails.logger.warn statement_row['query']
          Rails.logger.warn query.query
        end

        app_queries << query
      end
    end

    return app_queries
  end
end
