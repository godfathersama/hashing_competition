class CreateHashes < ActiveRecord::Migration
  def change
    create_table :hashes do |t|
      t.integer :user_id
      t.string :hash
      t.integer :score

      t.timestamps
    end
  end
end
