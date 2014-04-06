class Album < ActiveRecord::Base
  has_many :pictures, :dependent => :delete_all
  mount_uploader :cover, ImageUploader
end
