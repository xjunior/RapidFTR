require 'spec_helper'

describe SessionsController do

  it "should respond with text ok" do
    get :active
    response.body.should == 'OK'
  end

  it 'should record login activity on webapp' do
    user = mock_model(User)
    User.stub(:find_by_user_name).and_return(user)
    user.stub(:authenticate).and_return(true)
    user.stub(:user_name).and_return("tim")
    user.stub(:except).and_return({:user_name => 'tim'})

    activity = should_create_activity_for "sessions/create" do
      post :create, :user_name => "21321", :password => "123131"
    end
    activity.user_name.should == "tim"
    activity.imei.should be_nil
  end

  it 'should record login activity on mobile app' do
    pending
    activity = should_create_activity_for "sessions/create" do
      post :create, :user_name => "", :password => ""
    end
  end

end
