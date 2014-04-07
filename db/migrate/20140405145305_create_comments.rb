class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.integer :commentable_id
      t.string :ancestry
      t.string :commentable_type

      t.timestamps
    end
    add_index :comments, :ancestry
  end
end
