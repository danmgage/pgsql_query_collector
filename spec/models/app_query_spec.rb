require 'rails_helper'

RSpec.describe AppQuery, type: :model do
  describe '.map_from_pg_stat_statements' do
    let(:statement_query_1) { { queryid: 1, query: 'select * from t1' } }
    let(:statement_query_2) { { queryid: 2, query: 'select * from t2' } }
    let(:statement_query_3) { { queryid: 3, query: 'select * from t3' } }

    let(:statement_query_4) { { queryid: 1, query: 'select * from t4' } }

    it 'creates new queries' do
      app_queries = AppQuery.map_from_pg_stat_statements([statement_query_1, statement_query_2])

      expect(app_queries.size).to eq(2)
      expect(app_queries.first.queryid).to eq(statement_query_1[:queryid])
      expect(app_queries.first.query).to eq(statement_query_1[:query])
    end

    it 'finds existing statements' do
      app_queries = AppQuery.map_from_pg_stat_statements([statement_query_1, statement_query_2])

      expect(app_queries.size).to eq(2)
      expect(app_queries.first.queryid).to eq(statement_query_1[:queryid])
      expect(app_queries.first.query).to eq(statement_query_1[:query])

      app_queries_2 = AppQuery.map_from_pg_stat_statements([statement_query_1, statement_query_3])

      expect(app_queries_2.size).to eq(2)
      expect(app_queries_2.first.id).to eq(app_queries.first.id)
      expect(app_queries_2.last.id).to_not eq(app_queries.last.id)

      expect(AppQuery.count()).to eq(3)
    end

    it 'raises if queryid does not match query' do
      AppQuery.map_from_pg_stat_statements([statement_query_1, statement_query_2])

      expect { AppQuery.map_from_pg_stat_statements([statement_query_4])}.to raise_error(StandardError)
    end
  end
end
