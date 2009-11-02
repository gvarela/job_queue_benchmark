# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091102223458) do

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "image_files", :force => true do |t|
    t.integer  "size"
    t.string   "content_type", :limit => 50
    t.string   "filename"
    t.string   "thumbnail"
    t.integer  "height"
    t.integer  "width"
    t.integer  "parent_id"
    t.integer  "image_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "image_files", ["image_id"], :name => "index_image_files_on_image_id"
  add_index "image_files", ["parent_id"], :name => "index_image_files_on_parent_id"

  create_table "images", :force => true do |t|
    t.string   "name"
    t.string   "source_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
