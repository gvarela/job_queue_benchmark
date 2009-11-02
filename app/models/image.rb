class Image < ActiveRecord::Base
  has_one :image_file

  def image_data() nil; end

  def image_data=(file_data)
    return nil if file_data.nil? || file_data.size == 0
    image.nil? ? create_image_file(:uploaded_data => file_data) : image_file.update_attributes(:uploaded_data => file_data)
  end

  def fetch_image
    return false unless image_url
    temp_image_path = download_image_to_temp_file(image_url)
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
