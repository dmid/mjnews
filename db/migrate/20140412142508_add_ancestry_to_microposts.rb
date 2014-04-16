class AddAncestryToMicroposts < ActiveRecord::Migration
  def change
    add_column :microposts, :ancestry, :string
    add_index :microposts, :ancestry
  end

end
