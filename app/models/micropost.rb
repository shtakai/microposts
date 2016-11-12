class Micropost < ActiveRecord::Base
  paginates_per 5
  
  belongs_to :user
  
  has_many :favorites, dependent: :destroy
  
  validates :user_id, presence: true
  
  validates :content,
    presence: true,
    length:   { maximum: 140 }
    
end
