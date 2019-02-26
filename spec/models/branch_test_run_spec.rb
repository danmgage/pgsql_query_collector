require 'rails_helper'

describe BranchTestRun do
  describe 'relationships' do
    let(:branch) { Branch.create name: 'b1' }
    let(:branch_comparison) { BranchComparison.create }
    let(:query) { Query.create queryid: 1, query: 'select' }

    it 'works with all relationships' do
      branch_test_run = BranchTestRun.create branch: branch, branch_comparison: branch_comparison

      expect(branch.branch_test_runs).to include(branch_test_run)
      expect(branch_comparison.branch_test_runs).to include(branch_test_run)

      branch_test_run.queries << query

      expect(query.branch_test_runs).to include(branch_test_run)

      expect(branch.branch_comparisons).to include(branch_comparison)
      expect(branch_comparison.branches).to include(branch)
    end
  end
end