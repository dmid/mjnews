class CreateMicroposts < ActiveRecord::Migration
  def change
    create_table :microposts do |t|
      t.string :content
      t.integer :user_id
      t.integer :story_id
      t.string :comment_id
      t.boolean :parent_is_comment, default: FALSE
      t.integer :points, default: 0
      t.timestamps
    end
    add_index :microposts, [:user_id, :story_id, :created_at]
  end
end
