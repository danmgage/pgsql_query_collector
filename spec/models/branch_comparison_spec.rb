require 'rails_helper'

describe BranchComparison do
  describe '#collect_branch_queries' do
    let(:branch) { Branch.create name: 'b1' }
    let(:branch_comparison) { BranchComparison.create }

    let(:statements) {[
        { queryid: 1, query: 'select * from t1' },
        { queryid: 2, query: 'select * from t2' },
        { queryid: 3, query: 'select * from t3' },
    ]}

    it 'creates branch_test_run and queries' do
      expect(AppQuery).to receive(:get_stat_statements_for_db).and_return(statements)

      branch_test_run = branch_comparison.collect_branch_queries(branch)

      expect(branch_test_run).to be_a(BranchTestRun)
      expect(branch_test_run.app_queries.count).to eq(3)
    end
  end
end