module UsersHelper
  def user_activity_display(activity)
  	template = activity_template_for(activity)

  	render :partial => template, :locals => { :activity => activity }
  end

  private

  def activity_template_for(activity)
  	"activities/" + activity.event.gsub(/\//, "_")
  end
end
