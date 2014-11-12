class RenameColumnToArticles < ActiveRecord::Migration
  def change

	rename_column :articles, :releaced_at, :released_at

  end
end
