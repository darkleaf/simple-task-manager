class Story < ActiveRecord::Base
  belongs_to :user
  belongs_to :responsible_user, :class_name => "User"

  attr_accessible :title, :body, :responsible_user, :state

  validates :title, :presence => true,
                    :length   => { :maximum => 256 }    
  validates :body, :presence => true  

  state_machine :state, :initial => :new do
    
    event :start do
      transition :new => :started
    end
  
    event :finish do
      transition :started => :finished
    end

    event :accept do
      transition :finished => :accepted
    end

    event :reject do
      transition :finished => :rejected
    end
  end
end
