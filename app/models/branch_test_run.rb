class BranchTestRun < ApplicationRecord
  has_and_belongs_to_many :queries

  belongs_to :branch
  belongs_to :branch_comparison
end
