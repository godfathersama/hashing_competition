class RenameHashAsAttempt < ActiveRecord::Migration
  def change
    rename_column :attempts, :hash, :attempt
  end
end
