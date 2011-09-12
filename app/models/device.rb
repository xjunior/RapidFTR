class Device < CouchRestRails::Document
  use_database :device
  
  property :imei
  property :blacklisted, :cast_as => :boolean
  property :user_name

  view_by :imei
  view_by :user_name
end
