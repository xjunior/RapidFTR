require 'spec_helper'

describe "users/edit.html.erb" do
  describe "Viewing a user's mobile login history" do
    it "should show the login events" do
      user = User.new
      Time.stub!(:now).and_return Time.parse("2010-01-20 12:04:24UTC")
      user.add_mobile_login_event('1234', '01234 56789')
      user.time_zone = TZInfo::Timezone.get("US/Samoa")
      user.user_name = 'luis'

      assigns[:user] = user

      template.stub(:is_admin?).and_return(true)
      template.stub(:current_user).and_return(user)

      render
      
    end
  end
end
