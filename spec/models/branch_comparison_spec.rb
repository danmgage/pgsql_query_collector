require 'rails_helper'

describe BranchComparison do
  describe '#collect_branch_queries' do
    let(:branch) { Branch.create name: 'b1' }
    let(:branch_comparison) { BranchComparison.create }

    let(:statements) {[
        { 'queryid' => 1, 'query' => 'select * from t1' },
        { 'queryid' => 2, 'query' => 'select * from t2' },
        { 'queryid' => 3, 'query' => 'select * from t3' },
    ]}

    it 'creates branch_test_run and queries' do
      expect(PostgresDb::PgStatStatement).to receive(:statements_for_database).and_return(statements)

      branch_test_run = branch_comparison.collect_branch_queries(branch)

      expect(branch_test_run).to be_a(BranchTestRun)
      expect(branch_test_run.app_queries.count).to eq(3)
    end
  end

  describe '#additional_queries_for_branch' do
    let(:branch_1) { Branch.create name: 'b1' }
    let(:branch_2) { Branch.create name: 'b2' }

    let(:branch_comparison) { BranchComparison.create }

    let(:branch_1_test_run) { BranchTestRun.create branch: branch_1, branch_comparison: branch_comparison }
    let(:branch_2_test_run) { BranchTestRun.create branch: branch_2, branch_comparison: branch_comparison }

    let(:query1) { AppQuery.create queryid: 1, query: 'select * from t1' }
    let(:query2) { AppQuery.create queryid: 2, query: 'select * from t2' }
    let(:query3) { AppQuery.create queryid: 3, query: 'select * from t3' }

    it 'finds the difference both ways' do
      branch_1_test_run.app_queries << query1
      branch_1_test_run.app_queries << query3

      branch_2_test_run.app_queries << query3
      branch_2_test_run.app_queries << query2

      expect(branch_comparison.additional_queries_for_branch(branch_1)).to match_array([query1])
      expect(branch_comparison.additional_queries_for_branch(branch_2)).to match_array([query2])
    end
  end
end