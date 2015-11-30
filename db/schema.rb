# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20151130005405) do

  create_table "adcheques", force: :cascade do |t|
    t.binary   "ad_id",             limit: 16
    t.binary   "order_id",          limit: 16
    t.decimal  "amount",                        precision: 10
    t.binary   "ad_code",           limit: 16
    t.string   "redemption_status", limit: 255
    t.datetime "created_at",                                   null: false
    t.datetime "updated_at",                                   null: false
  end

  create_table "cards", force: :cascade do |t|
    t.string   "card_id",                 limit: 255
    t.string   "template_category",       limit: 255
    t.string   "custom_conf",             limit: 255
    t.string   "display_receipient_name", limit: 255
    t.string   "display_sender_message",  limit: 255
    t.string   "display_sender_name",     limit: 255
    t.string   "template_image_url",      limit: 255
    t.string   "sender_username",         limit: 255
    t.string   "card_status",             limit: 255
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "orders", force: :cascade do |t|
    t.binary   "order_id",       limit: 16
    t.string   "receiver_name",  limit: 255
    t.string   "receiver_email", limit: 255
    t.integer  "receiver_phone", limit: 4
    t.string   "card_id",        limit: 255
    t.decimal  "amount",                     precision: 10
    t.string   "order_status",   limit: 255
    t.datetime "created_at",                                null: false
    t.datetime "updated_at",                                null: false
  end

  create_table "payments", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "products", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receipts", force: :cascade do |t|
    t.binary   "ad_id",      limit: 16
    t.binary   "order_id",   limit: 16
    t.binary   "adr",        limit: 16
    t.datetime "created_at",            null: false
    t.datetime "updated_at",            null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "email",      limit: 255
    t.string   "password",   limit: 255
    t.integer  "phone",      limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

end
