class CreateImageFiles < ActiveRecord::Migration
  def self.up
    create_table :image_files do |t|
      t.integer  :size
      t.string   :content_type, :limit => 50
      t.string   :filename
      t.string   :thumbnail
      t.integer  :height
      t.integer  :width
      t.integer  :parent_id
      t.integer  :image_id
      t.timestamps
    end

    add_index :image_files, :image_id
    add_index :image_files, :parent_id
  end

  def self.down
    drop_table :image_files
  end
end
