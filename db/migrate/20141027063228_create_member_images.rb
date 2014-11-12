class CreateMemberImages < ActiveRecord::Migration
  def change
    create_table :member_images do |t|

      t.references :member, null: false   #外部キー
      t.binary :data, limit: 20.megabytes #画像データ(サイズ制限指定)
      t.string :content_type			  #MIMEタイプ

      t.timestamps
    end
    add_index :member_images, :member_id
  end
end
