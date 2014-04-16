class Micropost < ActiveRecord::Base
  belongs_to :story
  belongs_to :user
  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: :true
  validates :story_id, presence: :true
  validates :content, presence: true
  has_ancestry

end
