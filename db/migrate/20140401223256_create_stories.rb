class CreateStories < ActiveRecord::Migration
  def change
    create_table :stories do |t|
      t.string :title
      t.string :url
      t.integer :points
      t.integer :user_id

      t.timestamps
    end
    add_index :stories, [:user_id, :created_at]
  end
end
