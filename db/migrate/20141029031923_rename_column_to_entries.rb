class RenameColumnToEntries < ActiveRecord::Migration
  def change
	  rename_column :entries, :atatus, :status
  end
end
