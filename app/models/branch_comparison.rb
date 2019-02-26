class BranchComparison < ApplicationRecord
  has_many :branch_test_runs
  has_many :branches, through: :branch_test_runs
end
