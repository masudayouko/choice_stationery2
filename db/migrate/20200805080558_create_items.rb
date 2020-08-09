class CreateItems < ActiveRecord::Migration[5.2]
  def change
    create_table :items do |t|
      t.string :title
      t.text :comment
      t.string :genre_name
      t.string :image_id
      t.integer :genre_id
      t.integer :user_id
      t.timestamps
    end
  end
end
