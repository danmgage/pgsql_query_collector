require 'rails_helper'

RSpec.describe PostgresDb::PgStatStatement, type: :model do
  describe '.statements_for_database' do
    it 'returns queries' do
      statements = PostgresDb::PgStatStatement.statements_for_database('postgres')

      expect(statements.first['queryid']).to be > 0
    end
  end
end
