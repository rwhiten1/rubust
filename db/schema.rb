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

ActiveRecord::Schema.define(:version => 20090123200159) do

  create_table "cells", :force => true do |t|
    t.string   "data"
    t.integer  "row"
    t.integer  "col"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "fixture_sheet_id"
  end

  add_index "cells", ["fixture_sheet_id"], :name => "fk_cells_fixture_sheets"

  create_table "elements", :force => true do |t|
    t.integer  "position"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "resource_id",                   :null => false
    t.string   "resource_type", :default => "", :null => false
  end

  add_index "elements", ["page_id"], :name => "fk_elements_pages"

  create_table "fixture_sheets", :force => true do |t|
    t.string   "name"
    t.string   "fixture"
    t.integer  "rows"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "columns"
    t.boolean  "is_blank"
  end

  create_table "fixtures", :force => true do |t|
    t.string   "name"
    t.string   "path"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "headings", :force => true do |t|
    t.string   "value"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "methods", :force => true do |t|
    t.integer  "fixture_id"
    t.string   "template"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "methods", ["fixture_id"], :name => "fk_methods_fixtures"

  create_table "notes", :force => true do |t|
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pages", :force => true do |t|
    t.integer  "parent_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "test_tables", :force => true do |t|
    t.string   "name"
    t.string   "fixture"
    t.integer  "rows"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "variables", :force => true do |t|
    t.integer  "page_id"
    t.string   "name"
    t.string   "value"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "variables", ["page_id"], :name => "fk_variables_pages"

end
