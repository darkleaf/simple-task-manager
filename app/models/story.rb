class Story < ActiveRecord::Base
  belongs_to :user
  belongs_to :responsible_user, :class_name => "User"

  attr_accessible :title, :body, :responsible_user
 # validates :
end
