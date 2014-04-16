class Story < ActiveRecord::Base
  belongs_to :user
  has_many :followed_users, through: :relationships, source: :followed
  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy
  has_many :microposts
  default_scope -> { order('created_at DESC') }

  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140, minimum: 3}
  validates :url, presence: true, uniqueness: {case_sensitive: false}
end
