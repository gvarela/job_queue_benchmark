class ImageFile < ActiveRecord::Base
  has_attachment :content_type => :image, :resize_to => [50,50]
  belongs_to :image
end
