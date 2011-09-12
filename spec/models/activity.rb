require 'spec_helper'

def build_user( options = {} )
  options.reverse_merge!( {
    :user_name => "user_name_#{rand(10000)}",
    :full_name => 'full name',
    :password => 'password',
    :password_confirmation => options[:password] || 'password',
    :email => 'email@ddress.net',
    :user_type => 'user_type'
  })
  User.new(options) 
end

describe Activity do
  before do
    @user = build_user
    @user.save
  end

  it 'should get the device given the IMEI' do
    device = Device.create(:imei => "1234", :blacklisted => false)
    activity = Activity.create(:imei => device.imei, :user_name => @user.user_name, :event => "test/test")
    Activity.get(activity.id).device.imei == device.imei
  end

  it 'should map to the correct user' do
    activity = Activity.create(:user_name => @user.user_name, :event => "test/test")
    Activity.get(activity.id).user.user_name == @user.user_name
  end
end
