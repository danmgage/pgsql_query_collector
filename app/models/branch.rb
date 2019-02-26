class Branch < ApplicationRecord
  has_many :branch_test_runs
  has_many :branch_comparisons, through: :branch_test_runs
end
