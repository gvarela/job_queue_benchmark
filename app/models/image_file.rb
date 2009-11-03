class ImageFile < ActiveRecord::Base
  has_attachment :storage => :file_system,
                 :content_type => :image,
                 :resize_to => [50,50]
  belongs_to :image
end
