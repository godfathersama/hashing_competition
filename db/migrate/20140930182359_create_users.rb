class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :hash
      t.integer :score
      t.string :email

      t.timestamps
    end
  end
end
