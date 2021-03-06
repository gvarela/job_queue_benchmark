require 'action_controller'
require 'action_controller/test_process.rb'

class Image < ActiveRecord::Base
  include ResqueAsync
  
  IMAGE_TEMP_PATH = File.join(RAILS_ROOT, 'tmp', 'images')

  has_one :image_file

  def self.find_and_fetch_by_name(name)
    image = Image.find_by_name(name)
    image.fetch_image
  end

  def image_data() nil; end

  def image_data=(file_data)
    return nil if file_data.nil? || file_data.size == 0
    image_file.nil? ? create_image_file(:uploaded_data => file_data) : image_file.update_attributes(:uploaded_data => file_data)
  end

  def fetch_image
    return false unless source_url
    temp_image_path = download_image_to_temp_file(source_url)
    uploaded_image = ActionController::TestUploadedFile.new(temp_image_path, 'image/jpeg')
    self.image_data = uploaded_image
    File.delete temp_image_path
  end
  protected

    def download_image_to_temp_file(url)
      FileUtils.mkdir_p IMAGE_TEMP_PATH
      temp_file_path = File.join(IMAGE_TEMP_PATH, "#{rand Time.now.to_i}.jpg")
      rio(url) > rio(temp_file_path)
      return temp_file_path
    end

end
