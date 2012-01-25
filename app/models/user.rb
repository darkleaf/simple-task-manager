class User < ActiveRecord::Base
  has_many :stories, :dependent => :destroy
  #у пользователя могут быть задачи
  has_many :tasks, :class_name => "Story", #задачи находятся в таблице Story
                   :dependent => :nullify, #если удаляем пользователя, вместо него подставляем - NULL
                   :foreign_key => "responsible_user_id"



  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  attr_accessible :name, :email
  validates :name, :presence => true,
                   :length   => { :maximum => 50 }
  validates :email, :presence => true,
                    :format   => { :with => email_regex },
                    :uniqueness => { :case_sensitive => false }
end
