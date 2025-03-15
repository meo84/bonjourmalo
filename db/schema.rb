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

ActiveRecord::Schema[8.0].define(version: 2025_03_15_120807) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "visibility_status", ["internal", "public"]

  create_table "articles", force: :cascade do |t|
    t.string "uuid", null: false
    t.string "title"
    t.string "slug"
    t.boolean "featured"
    t.enum "visibility", default: "internal", enum_type: "visibility_status"
    t.datetime "published_at"
    t.string "url"
    t.text "excerpt"
    t.integer "reading_time"
    t.boolean "access"
    t.boolean "comments"
    t.string "og_image_url"
    t.string "og_title"
    t.string "meta_title"
    t.text "meta_description"
    t.string "feature_image_url"
    t.string "feature_image_alt"
    t.text "feature_image_caption"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["uuid"], name: "index_articles_on_uuid", unique: true
  end

  create_table "articles_tags", force: :cascade do |t|
    t.bigint "article_id", null: false
    t.bigint "tag_id", null: false
    t.boolean "primary", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id", "primary"], name: "index_articles_tags_on_article_id_and_primary", unique: true, where: "(\"primary\" = true)"
    t.index ["article_id", "tag_id"], name: "index_articles_tags_on_article_id_and_tag_id", unique: true
    t.index ["article_id"], name: "index_articles_tags_on_article_id"
    t.index ["tag_id"], name: "index_articles_tags_on_tag_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug"
    t.text "description"
    t.string "feature_image_url"
    t.enum "visibility", default: "internal", enum_type: "visibility_status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  add_foreign_key "articles_tags", "articles"
  add_foreign_key "articles_tags", "tags"
end
