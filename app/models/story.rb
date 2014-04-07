class Story < ActiveRecord::Base  


  VALID_URL_REGEX =  /((([A-Za-z]{3,9}:(?:\/\/)?)(?:[\-;:&=\+\$,\w]+@)?[A-Za-z0-9\.\-]+|(?:www\.|[\-;:&=\+\$,\w]+@)[A-Za-z0-9\.\-]+)((?:\/[\+~%\/\.\w\-_]*)?\??(?:[\-\+=&;%@\.\w_]*)#?(?:[\.\!\/\\\w]*))?)/

  belongs_to :user
  
  has_many :followed_users, through: :relationships, source: :followed
  has_many :comments, :as => :commentable, :dependent => :destroy

  has_many :reverse_relationships, foreign_key: "followed_id", class_name: "Relationship", dependent: :destroy

  

  default_scope -> { order('created_at DESC') }
  validates :user_id, presence: true
  validates :title, presence: true, length: { maximum: 140, minimum: 3}
  validates :url, presence: true



  

 
end
