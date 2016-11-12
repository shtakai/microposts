class Favolite < ActiveRecord::Base
  belongs_to :user
  belongs_to :micropost#, dependent: :destroy
  
end

