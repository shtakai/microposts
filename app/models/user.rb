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
  
  validates :url,
    length: { maximum: 255 },
    format: { with: URI.regexp },
    if: 'url.present?'
    
  validates :profile, :location,
    length: { maximum: 255 }
  
  has_secure_password
end
