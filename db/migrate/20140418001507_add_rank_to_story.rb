class AddRankToStory < ActiveRecord::Migration
  def change
    add_column :stories, :rank, :float
  end
end
