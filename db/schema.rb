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

ActiveRecord::Schema[7.1].define(version: 2024_06_24_144857) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "postgis"

  create_table "addresses", force: :cascade do |t|
    t.bigint "house_id"
    t.string "street"
    t.string "neighborhood"
    t.string "city"
    t.string "state"
    t.string "zip_code"
    t.string "country_code"
    t.geography "geolocation", limit: {:srid=>4326, :type=>"st_point", :geographic=>true}, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["geolocation"], name: "index_addresses_on_geolocation", using: :gist
    t.index ["house_id"], name: "index_addresses_on_house_id"
  end

  create_table "houses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.integer "bathrooms"
    t.integer "bedrooms"
    t.integer "price_per_night"
    t.integer "price_per_week"
    t.integer "price_per_month"
    t.date "available_from"
    t.date "available_until"
    t.string "general_address"
    t.json "title"
    t.json "subtitle"
    t.json "description"
    t.boolean "paid"
    t.boolean "admin_approved"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["admin_approved"], name: "index_houses_on_admin_approved"
    t.index ["available_from"], name: "index_houses_on_available_from"
    t.index ["available_until"], name: "index_houses_on_available_until"
    t.index ["bathrooms"], name: "index_houses_on_bathrooms"
    t.index ["bedrooms"], name: "index_houses_on_bedrooms"
    t.index ["paid"], name: "index_houses_on_paid"
    t.index ["user_id"], name: "index_houses_on_user_id"
  end

  create_table "images", force: :cascade do |t|
    t.bigint "house_id"
    t.string "url"
    t.integer "position"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["house_id"], name: "index_images_on_house_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "addresses", "houses"
  add_foreign_key "houses", "users"
  add_foreign_key "images", "houses"
end
