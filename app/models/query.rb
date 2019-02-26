class Query < ApplicationRecord
  has_and_belongs_to_many :branch_test_runs
end
