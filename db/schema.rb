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

ActiveRecord::Schema.define(version: 20151112051843) do

  create_table "shortened_urls", force: :cascade do |t|
    t.string   "long_url",     null: false
    t.string   "short_url",    null: false
    t.integer  "submitter_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "shortened_urls", ["short_url"], name: "index_shortened_urls_on_short_url", unique: true
  add_index "shortened_urls", ["submitter_id"], name: "index_shortened_urls_on_submitter_id"

  create_table "tag_topics", force: :cascade do |t|
    t.string   "topic",      null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tag_topics", ["topic"], name: "index_tag_topics_on_topic", unique: true

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_topic_id",     null: false
    t.integer  "shortened_url_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "taggings", ["shortened_url_id"], name: "index_taggings_on_shortened_url_id"
  add_index "taggings", ["tag_topic_id"], name: "index_taggings_on_tag_topic_id"

  create_table "users", force: :cascade do |t|
    t.string   "email_address", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email_address"], name: "index_users_on_email_address", unique: true

  create_table "visits", force: :cascade do |t|
    t.integer  "visitor_id",       null: false
    t.integer  "shortened_url_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "visits", ["shortened_url_id"], name: "index_visits_on_shortened_url_id"
  add_index "visits", ["visitor_id"], name: "index_visits_on_visitor_id"

end
