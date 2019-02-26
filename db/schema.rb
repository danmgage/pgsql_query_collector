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

ActiveRecord::Schema.define(version: 2019_02_26_124039) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "branch_comparisons", force: :cascade do |t|
    t.text "comments"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "branch_test_runs", force: :cascade do |t|
    t.bigint "branch_id"
    t.bigint "branch_comparison_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["branch_comparison_id"], name: "index_branch_test_runs_on_branch_comparison_id"
    t.index ["branch_id"], name: "index_branch_test_runs_on_branch_id"
  end

  create_table "branch_test_runs_queries", id: false, force: :cascade do |t|
    t.bigint "branch_test_run_id"
    t.bigint "query_id"
    t.index ["branch_test_run_id"], name: "index_branch_test_runs_queries_on_branch_test_run_id"
    t.index ["query_id"], name: "index_branch_test_runs_queries_on_query_id"
  end

  create_table "branches", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_branches_on_name"
  end

  create_table "queries", force: :cascade do |t|
    t.bigint "queryid"
    t.text "query"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
