class ModifyMembers < ActiveRecord::Migration
  def change

  	add_column :members, :phone, :string

  end
end
