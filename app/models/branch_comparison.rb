class BranchComparison < ApplicationRecord
  has_many :branch_test_runs
  has_many :branches, through: :branch_test_runs

  # @param branch [Branch] the branch for which we collect the queries
  # @return [BranchTestRun] the branch test run with the collected queries
  def collect_branch_queries(branch)
    raise StandardError.new('branch queries already collected') if branch_test_runs.where(branch: branch).count > 0
    raise StandardError.new('already two branches') if branch_test_runs.count >= 2

    branch_test_run = branch_test_runs.create(branch: branch)

    branch_test_run.collect_queries(EXTERNAL_DATABASE[:name])

    return branch_test_run
  end
end
