class Activity < CouchRestRails::Document
  include CouchRest::Validation

  use_database :activity
  
  property :ip_address
  property :imei
  property :mobile_number
  property :description
  property :event
  property :child_id
  property :user_name
  
  timestamps!
  
  unique_id :id

  validates_presence_of :user_name
  validates_presence_of :event

  view_by :event
  view_by :user_name

  def device
    @device ||= Device.by_imei(:key => imei).first
  end

  def child
    @child ||= Child.get(child_id)
  end

  def user
    @user ||= User.find_by_user_name(user_name)
  end
end
