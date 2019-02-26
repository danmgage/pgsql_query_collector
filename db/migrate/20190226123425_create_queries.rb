class CreateQueries < ActiveRecord::Migration[5.2]
  def change
    create_table :queries do |t|
      t.integer :queryid, :limit => 8
      t.text    :query

      t.timestamps
    end
  end
end
