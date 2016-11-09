class User < ActiveRecord::Base
  before_save { self.email = self.email.downcase } 
  
  validates :name, 
    presence: true,
    length: { maximum: 50 }
  
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
    presence: true,
    length: { maximum: 255 },
    format: { with: VALID_EMAIL_REGEX },
    uniqueness: { case_sentitive: false }
  
  has_secure_password
  
  has_many :microposts
  
  # followee: users who this user follows
  has_many :following_relationships, class_name: "Relationship",
                                     foreign_key: "follower_id",
                                     dependent: :destroy
  has_many :following_users, through: :following_relationships, source: :followed
  
  
  # follower: users who follows this user
  has_many :follower_relationship,   class_name: "Relationship",
                                     foreign_key: "followed_id",
                                     dependent: :destroy
  has_many :follower_users, through: :follower_relationship, source: :follower 
  
  
  # follow other user
  def follow(other_user)
    following_relationships.find_or_create_by(followed_id: other_user.id)
  end
  
  # unfollow the following user
  def unfollow(other_user)
    following_relationship = following_relationships.find_by(
      followed_id: other_user.id
    )
    following_relationship.destroy if following_relationship
  end
  
  # check if this user follows other user
  def following?(other_user)
    following_users.include?(other_user)
  end
  
end
