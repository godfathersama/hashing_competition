class ChangeHashToKey < ActiveRecord::Migration
  def change
    rename_column :users, :hash, :key
  end
end
