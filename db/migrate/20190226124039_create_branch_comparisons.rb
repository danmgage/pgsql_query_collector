class CreateBranchComparisons < ActiveRecord::Migration[5.2]
  def change
    create_table :branch_comparisons do |t|
      t.text :comments

      t.timestamps
    end
  end
end
