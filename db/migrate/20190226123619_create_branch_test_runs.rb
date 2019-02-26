class CreateBranchTestRuns < ActiveRecord::Migration[5.2]
  def change
    create_table :branch_test_runs do |t|
      t.references :branch
      t.references :branch_comparison

      t.timestamps
    end

    create_table :branch_test_runs_queries, id: false do |t|
      t.references :branch_test_run
      t.references :query
    end
  end
end
