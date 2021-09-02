# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_09_02_160655) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "certifications", force: :cascade do |t|
    t.string "name"
    t.string "surname"
    t.string "category"
    t.binary "qr_code"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "date_of_birth"
    t.string "disease_target"
    t.string "vaccine_or_prophylaxis"
    t.string "medicinal_product"
    t.string "marketing_authorization_holder"
    t.integer "dose_number"
    t.integer "series_of_doses"
    t.date "vaccination_date"
    t.string "vaccination_country"
    t.string "issuer"
    t.string "uvci"
  end

  create_table "value_sets", force: :cascade do |t|
    t.string "value_set_id"
    t.date "value_set_date"
    t.string "code"
    t.string "display"
    t.string "lang"
    t.boolean "active"
    t.string "version"
    t.string "system"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

end
