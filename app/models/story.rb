class Story < ActiveRecord::Base
  belongs_to :user
  belongs_to :responsible_user, :class_name => "User"

  attr_accessible :title, :body, :responsible_user
  #validates :title, :presence => true,
  #                  :length   => { :maximum => 256 }    
  #validates :body, :presence => true  
end
