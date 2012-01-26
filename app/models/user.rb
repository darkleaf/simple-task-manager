class User < ActiveRecord::Base
  has_many :stories, :dependent => :destroy
  has_many :tasks, :class_name => "Story",
                   :dependent => :nullify,
                   :foreign_key => "responsible_user_id"

  attr_accessible :name, :email, :password, :password_confirmation
  has_secure_password
  validates_presence_of :password, :on => :create

  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  validates :name, :presence => true,
                   :length   => { :maximum => 50 }
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
end
