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

ActiveRecord::Schema.define(:version => 20101231055339) do

  create_table "applied_offs", :force => true do |t|
    t.integer  "day_off_id",           :default => 0,  :null => false
    t.integer  "employee_id",          :default => 0,  :null => false
    t.string   "applied_leave_status", :default => "", :null => false
    t.datetime "from_date",                            :null => false
    t.datetime "to_date",                              :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "day_offs", :force => true do |t|
    t.string   "leave_policy_id", :limit => 50,                               :default => "",  :null => false
    t.integer  "employee_id",                                                 :default => 0,   :null => false
    t.decimal  "casual_offs",                   :precision => 4, :scale => 1, :default => 0.0, :null => false
    t.decimal  "paid_offs",                     :precision => 4, :scale => 1, :default => 0.0, :null => false
    t.decimal  "sick_offs",                     :precision => 4, :scale => 1, :default => 0.0, :null => false
    t.decimal  "earned_offs",                   :precision => 4, :scale => 1, :default => 0.0
    t.decimal  "maternity_offs",                :precision => 4, :scale => 1, :default => 0.0, :null => false
    t.integer  "year",                                                        :default => 0,   :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "designations", :force => true do |t|
    t.string   "designation_type", :limit => 50, :default => "", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "employees", :force => true do |t|
    t.string   "employee_code",             :limit => 30,  :default => "", :null => false
    t.string   "login",                     :limit => 40,  :default => "", :null => false
    t.string   "first_name",                :limit => 100, :default => "", :null => false
    t.string   "last_name",                 :limit => 100, :default => "", :null => false
    t.string   "gender",                    :limit => 1,   :default => "", :null => false
    t.string   "email",                     :limit => 100
    t.integer  "designation_id",                                           :null => false
    t.integer  "manager_id"
    t.datetime "joining_date",                                             :null => false
    t.string   "crypted_password",          :limit => 40
    t.string   "salt",                      :limit => 40
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "remember_token",            :limit => 40
    t.datetime "remember_token_expires_at"
  end

  add_index "employees", ["login"], :name => "index_employees_on_login", :unique => true

  create_table "leave_policies", :force => true do |t|
    t.string  "day_off_type",                               :default => "",  :null => false
    t.decimal "no_of_days",   :precision => 4, :scale => 1, :default => 0.0, :null => false
    t.string  "span_type",                                  :default => "",  :null => false
  end

end
