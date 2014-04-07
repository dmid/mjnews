class User < ActiveRecord::Base

  has_many :stories
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy

  has_many :reverse_relationships, foreign_key: "follower_id", class_name: "Relationship", dependent: :destroy
  
  

  has_many :followed_stories, through: :relationships, source: :followed
  

  before_save{self.email = email.downcase}
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: {case_sensitive: false}

  has_secure_password
  validates :password, length: {minimum: 6}
  before_create :create_remember_token



  def following?(story)
    relationships.find_by(followed_id: story) 
  end

  def follow!(story)
    relationships.create(followed_id: story) #passing the story.id
  end

  def unfollow!(story)
    relationships.find_by(followed_id: story).destroy
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end




  private

  def create_remember_token
    self.remember_token = User.hash(User.new_remember_token)
  end
end
