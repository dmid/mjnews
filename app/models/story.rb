class Story < ActiveRecord::Base  
  belongs_to :user
  has_many :followed_users, through: :relationships, source: :followed

  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy

  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
end
