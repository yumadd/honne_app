class CreatePosts < ActiveRecord::Migration[8.1]
  def change
    create_table :posts do |t|
      t.text :content, null: false
      t.string :bg_color
      t.string :category
      t.string :emotion
      t.integer :likes_count, null: false, default: 0

      t.timestamps
    end
  end
end
