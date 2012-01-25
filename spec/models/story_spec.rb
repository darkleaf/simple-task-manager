require 'spec_helper'

describe Story do

  before(:each) do
    @user = Factory(:user)
    @responsible_user = Factory(:user, :email => "other@email.ru")
    @attr = { :title => "Example Task", 
              :body => "Do smth", 
              :responsible_user => @responsible_user }
  end
  
  #проверка работоспособности
  it "should create a new instance given valid attributes" do
    @user.stories.create!(@attr)
  end


  describe "story associations" do

    before(:each) do
      @story = @user.stories.create(@attr)
    end

    it "should have a user attribute" do
      @story.should respond_to(:user)
    end

    it "should have the right associated user" do
      @story.user_id.should == @user.id
      @story.user.should == @user
    end

    it "should have a responsible_user attribute" do
      @story.should respond_to(:responsible_user)
    end

    it "should have the right associated responsible_user" do
      @story.responsible_user_id.should == @responsible_user.id
      @story.responsible_user.should == @responsible_user
    end

  end

  it "should require a title" do
    no_title_story = @user.stories.create(@attr.merge(:title => ""))
    no_title_story.should_not be_valid
  end

  it "should require a body" do
    no_body_story = @user.stories.create(@attr.merge(:body => ""))
    no_body_story.should_not be_valid
  end

  it "should reject title that are too long" do
    long_title = "a" * 257
    long_title_story = @user.stories.create(@attr.merge(:title => long_title))
    long_title_story.should_not be_valid
  end

  describe "states" do

    before(:each) do
      @story = @user.stories.create(@attr)
    end

    it "should create a new story with state new" do
      @story.new?.should be_true
    end

    it "should change status from new to started only" do
      @story.state = 'new'
      @story.can_start?.should be_true
      @story.can_finish?.should be_false
      @story.can_accept?.should be_false
      @story.can_reject?.should be_false
    end

    it "should change status from started to finished only" do
      @story.state = 'started'
      @story.can_start?.should be_false
      @story.can_finish?.should be_true
      @story.can_accept?.should be_false
      @story.can_reject?.should be_false
    end

    it "should change status from finished to accepted or rejected only" do
      @story.state = 'finished'
      @story.can_start?.should be_false
      @story.can_finish?.should be_false
      @story.can_accept?.should be_true
      @story.can_reject?.should be_true
    end

  end
end
