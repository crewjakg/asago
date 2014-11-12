class RenameColumnToMembers1 < ActiveRecord::Migration
  def change
  	rename_column :members, :hashed_password, :password_digest
  end
end
