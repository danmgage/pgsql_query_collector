class CreateBranches < ActiveRecord::Migration[5.2]
  def change
    create_table :branches do |t|
      t.string :name, index: :unique

      t.timestamps
    end
  end
end
