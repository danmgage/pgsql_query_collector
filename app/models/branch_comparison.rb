class BranchComparison < ApplicationRecord
  has_many :branch_test_runs
  has_many :branches, through: :branch_test_runs

  # @param branch [Branch] the branch for which we collect the queries
  # @return [BranchTestRun] the branch test run with the collected queries
  def collect_branch_queries(branch)
    branch_test_run = branch_test_runs.create(branch: branch)

    branch_test_run.collect_queries('test')

    return branch_test_run
  end
end
