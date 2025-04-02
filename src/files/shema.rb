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

ActiveRecord::Schema[7.0].define(version: 2025_03_12_035840) do
    # These are extensions that must be enabled in order to support this database
    enable_extension "pg_trgm"
    enable_extension "pgcrypto"
    enable_extension "plpgsql"
  
    create_table "action_processes", force: :cascade do |t|
      t.string "actionable_type"
      t.bigint "actionable_id"
      t.integer "sequence", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "business_process_id"
      t.index ["actionable_type", "actionable_id", "business_process_id"], name: "index_actionable_type_business_process", unique: true
      t.index ["actionable_type", "actionable_id"], name: "index_action_processes_on_actionable"
      t.index ["business_process_id"], name: "index_action_processes_on_business_process_id"
    end
  
    create_table "active_storage_attachments", force: :cascade do |t|
      t.string "name", null: false
      t.string "record_type", null: false
      t.bigint "record_id", null: false
      t.bigint "blob_id", null: false
      t.datetime "created_at", precision: nil, null: false
      t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
    end
  
    create_table "active_storage_blobs", force: :cascade do |t|
      t.string "key", null: false
      t.string "filename", null: false
      t.string "content_type"
      t.text "metadata"
      t.bigint "byte_size", null: false
      t.string "checksum", null: false
      t.datetime "created_at", precision: nil, null: false
      t.string "service_name", null: false
      t.index ["key"], name: "index_active_storage_blobs_on_key"
    end
  
    create_table "active_storage_variant_records", force: :cascade do |t|
      t.bigint "blob_id", null: false
      t.string "variation_digest", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
    end
  
    create_table "agents", force: :cascade do |t|
      t.string "owner_type"
      t.bigint "owner_id"
      t.bigint "project_id", null: false
      t.uuid "llm_id"
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.string "name", null: false
      t.string "key", null: false
      t.string "description"
      t.boolean "disabled", default: false
      t.jsonb "supported_platforms", default: [], array: true
      t.jsonb "metadata", default: {}
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["llm_id"], name: "index_agents_on_llm_id"
      t.index ["owner_type", "owner_id"], name: "index_agents_on_owner"
      t.index ["project_id"], name: "index_agents_on_project_id"
    end
  
    create_table "api_authorization_groups", force: :cascade do |t|
      t.string "name", null: false
      t.bigint "table_definition_id", null: false
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_api_authorization_groups_on_project_id"
      t.index ["table_definition_id"], name: "index_api_authorization_groups_on_table_definition_id"
    end
  
    create_table "api_functions", force: :cascade do |t|
      t.integer "category", null: false
      t.string "name", null: false
      t.integer "request_type", null: false
      t.integer "resource_type", default: 0, null: false
      t.integer "protocol"
      t.string "end_point", null: false
      t.string "scope"
      t.string "next_function_type"
      t.bigint "next_function_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "test_success", default: false
      t.datetime "test_success_date", precision: nil
      t.boolean "authentication_required", default: true
      t.bigint "table_definition_id"
      t.bigint "project_id"
      t.integer "status", default: 0
      t.bigint "crud_table_definition_id"
      t.integer "api_authorization_group_id"
      t.boolean "writable", default: true
      t.string "description"
      t.integer "created_by", default: 0, null: false
      t.boolean "restrict_access", default: false
      t.index ["crud_table_definition_id"], name: "index_api_functions_on_crud_table_definition_id"
      t.index ["end_point", "request_type", "scope", "project_id"], name: "endpoint_uniqueness", unique: true
      t.index ["next_function_type", "next_function_id"], name: "index_api_functions_on_next_function"
      t.index ["project_id"], name: "index_api_functions_on_project_id"
      t.index ["table_definition_id"], name: "index_api_functions_on_table_definition_id"
    end
  
    create_table "api_policies", force: :cascade do |t|
      t.integer "authorized_table_id", null: false
      t.integer "role_column_id"
      t.integer "role_value_id"
      t.integer "role_scope", default: 0
      t.bigint "api_authorization_group_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["api_authorization_group_id"], name: "index_api_policies_on_api_authorization_group_id"
    end
  
    create_table "api_scopes", force: :cascade do |t|
      t.integer "joining_condition", default: 0
      t.integer "query"
      t.integer "target_table_id", null: false
      t.integer "target_column_id", null: false
      t.string "target_value_type"
      t.bigint "target_value_id"
      t.bigint "api_policy_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["api_policy_id"], name: "index_api_scopes_on_api_policy_id"
      t.index ["target_value_type", "target_value_id"], name: "index_api_scopes_on_target_value"
    end
  
    create_table "app_page_localizations", force: :cascade do |t|
      t.bigint "localization_id"
      t.string "app_page_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["localization_id"], name: "index_app_page_localizations_on_localization_id"
    end
  
    create_table "arguments", force: :cascade do |t|
      t.string "name", null: false
      t.integer "of_type"
      t.integer "data_type", null: false
      t.bigint "parent_id"
      t.string "obj_reference_type"
      t.bigint "obj_reference_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "message_passing_type"
      t.bigint "message_passing_id"
      t.boolean "required", default: true
      t.integer "expected_request_category", default: 0
      t.string "description"
      t.boolean "depricated", default: false
      t.index ["message_passing_type", "message_passing_id"], name: "index_arguments_on_message_passing"
      t.index ["obj_reference_type", "obj_reference_id"], name: "index_arguments_on_obj_reference"
      t.index ["parent_id"], name: "index_arguments_on_parent_id"
    end
  
    create_table "authorization_conditions", force: :cascade do |t|
      t.bigint "api_authorization_group_id", null: false
      t.bigint "column_definition_id", null: false
      t.string "variable_type"
      t.bigint "variable_id"
      t.integer "joining_condition", null: false
      t.integer "query", null: false
      t.integer "order"
      t.string "default_value"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["api_authorization_group_id"], name: "index_authorization_conditions_on_api_authorization_group_id"
      t.index ["column_definition_id"], name: "index_authorization_conditions_on_column_definition_id"
      t.index ["variable_type", "variable_id"], name: "index_authorization_conditions_on_variable"
    end
  
    create_table "authorization_endpoints", force: :cascade do |t|
      t.bigint "api_authorization_group_id"
      t.bigint "api_function_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["api_authorization_group_id", "api_function_id"], name: "idx_authorization_group_endpoint", unique: true
      t.index ["api_authorization_group_id"], name: "index_authorization_endpoints_on_api_authorization_group_id"
      t.index ["api_function_id"], name: "index_authorization_endpoints_on_api_function_id"
    end
  
    create_table "block_versions", force: :cascade do |t|
      t.string "item_type"
      t.string "{:null=>false, :limit=>191}"
      t.bigint "item_id", null: false
      t.string "event", null: false
      t.string "whodunnit"
      t.text "object"
      t.text "object_changes"
      t.datetime "created_at", precision: nil
      t.index ["item_type", "item_id"], name: "index_block_versions_on_item_type_and_item_id"
    end
  
    create_table "blocks", force: :cascade do |t|
      t.string "name"
      t.string "node_id"
      t.string "parent_node_id"
      t.string "page_node_id"
      t.string "block_type"
      t.jsonb "content", default: [], array: true
      t.jsonb "properties", default: {}
      t.bigint "project_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "children", default: [], array: true
      t.integer "status", default: 0
      t.datetime "deleted_at"
      t.index "((properties ->> 'business_logic_ids'::text))", name: "index_block_business_logic_ids"
      t.index "((properties ->> 'ticket_generate_step'::text))", name: "index_block_props_ticket_generate_step"
      t.index "((properties ->> 'ticket_ids'::text))", name: "index_block_props_ticket_ids"
      t.index "((properties ->> 'ticket_type'::text))", name: "index_ticket_type"
      t.index "((properties ->> 'use_case_id'::text))", name: "index_block_props_use_case_id"
      t.index "((properties ->> 'use_case_ids'::text))", name: "index_block_props_use_case_ids"
      t.index "project_id, ((properties ->> 'category'::text))", name: "index_block_props_category_and_project_id"
      t.index ["node_id"], name: "index_blocks_on_node_id", unique: true
      t.index ["page_node_id"], name: "index_blocks_on_page_node_id"
      t.index ["parent_node_id"], name: "index_blocks_on_parent_node_id"
      t.index ["project_id"], name: "index_blocks_on_project_id"
      t.index ["properties"], name: "index_block_props_category_api", where: "((properties ->> 'category'::text) = 'api'::text)", using: :gin
      t.index ["properties"], name: "index_block_props_category_businesss_logic", where: "((properties ->> 'category'::text) = 'business_logic'::text)", using: :gin
      t.index ["properties"], name: "index_block_props_category_specification", where: "((properties ->> 'category'::text) = 'specification'::text)", using: :gin
    end
  
    create_table "blocks_locks", force: :cascade do |t|
      t.bigint "block_id", null: false
      t.bigint "user_id", null: false
      t.string "language_code", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["block_id"], name: "index_blocks_locks_on_block_id"
      t.index ["user_id"], name: "index_blocks_locks_on_user_id"
    end
  
    create_table "blocks_table_definitions", force: :cascade do |t|
      t.bigint "block_id", null: false
      t.bigint "table_definition_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.datetime "deleted_at"
      t.index ["block_id"], name: "index_blocks_table_definitions_on_block_id"
      t.index ["table_definition_id"], name: "index_blocks_table_definitions_on_table_definition_id"
    end
  
    create_table "blocks_translations", force: :cascade do |t|
      t.bigint "block_id", null: false
      t.string "name"
      t.jsonb "content", default: []
      t.string "language_code", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["block_id", "language_code"], name: "index_blocks_translations_on_block_id_and_language_code", unique: true
      t.index ["block_id"], name: "index_blocks_translations_on_block_id"
    end
  
    create_table "branding_colors", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.string "type_of_color", null: false
      t.string "value", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_branding_colors_on_project_id"
      t.index ["type_of_color", "project_id"], name: "index_branding_colors_on_type_of_color_and_project_id", unique: true
    end
  
    create_table "business_logic_groups", force: :cascade do |t|
      t.bigint "group_id", null: false
      t.bigint "block_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["block_id"], name: "index_business_logic_groups_on_block_id"
      t.index ["group_id"], name: "index_business_logic_groups_on_group_id"
    end
  
    create_table "business_processes", force: :cascade do |t|
      t.string "name"
      t.text "description"
      t.bigint "project_id"
      t.boolean "activate", default: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "status", default: 0
      t.index ["name", "project_id"], name: "index_business_processes_on_name_and_project_id", unique: true
      t.index ["project_id"], name: "index_business_processes_on_project_id"
    end
  
    create_table "categories", force: :cascade do |t|
      t.string "name", null: false
      t.integer "category_type"
      t.integer "project_type"
      t.integer "order"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["name", "category_type", "project_type"], name: "index_categories_on_name_and_category_type_and_project_type", unique: true
      t.index ["name"], name: "index_categories_on_name"
    end
  
    create_table "chat_prompt_tips", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.text "content", null: false
      t.string "assistant", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.index ["project_id"], name: "index_chat_prompt_tips_on_project_id"
      t.index ["uuid"], name: "index_chat_prompt_tips_on_uuid", unique: true
    end
  
    create_table "chats", force: :cascade do |t|
      t.bigint "user_id", null: false
      t.bigint "project_id", null: false
      t.string "status", default: "inprogress"
      t.string "created_from"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.jsonb "metadata", default: {}
      t.string "source_type"
      t.bigint "source_id"
      t.string "title"
      t.index ["project_id"], name: "index_chats_on_project_id"
      t.index ["source_type", "source_id"], name: "index_chats_on_source"
      t.index ["user_id"], name: "index_chats_on_user_id"
      t.index ["uuid"], name: "index_chats_on_uuid", unique: true
    end
  
    create_table "code_pushes", force: :cascade do |t|
      t.bigint "repository_id", null: false
      t.string "branch_name", null: false
      t.integer "status", default: 0, null: false
      t.text "message"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["repository_id"], name: "index_code_pushes_on_repository_id"
    end
  
    create_table "collaborators", force: :cascade do |t|
      t.string "collaboratable_type", null: false
      t.bigint "collaboratable_id", null: false
      t.bigint "organisation_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.index ["collaboratable_type", "collaboratable_id", "organisation_id"], name: "index_collaborators_on_collaboratable_and_organisation", unique: true
      t.index ["organisation_id"], name: "index_collaborators_on_organisation_id"
    end
  
    create_table "column_definition_indices", force: :cascade do |t|
      t.bigint "column_definition_id", null: false
      t.bigint "table_definition_index_id", null: false
      t.string "uuid"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["column_definition_id", "table_definition_index_id"], name: "table_definition_column_index", unique: true
      t.index ["column_definition_id"], name: "index_column_definition_indices_on_column_definition_id"
      t.index ["table_definition_index_id"], name: "index_column_definition_indices_on_table_definition_index_id"
    end
  
    create_table "column_definition_validations", force: :cascade do |t|
      t.bigint "column_definition_id", null: false
      t.string "validation_type", null: false
      t.json "validations"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "managed_by", default: 0
      t.index ["column_definition_id"], name: "index_column_definition_validations_on_column_definition_id"
    end
  
    create_table "column_definitions", force: :cascade do |t|
      t.bigint "table_definition_id", null: false
      t.string "name", null: false
      t.integer "column_type", null: false
      t.boolean "required", default: false, null: false
      t.boolean "unique", default: false, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "display_name", null: false
      t.bigint "relation_id"
      t.integer "order", default: 0, null: false
      t.string "default_value"
      t.string "comment", default: ""
      t.datetime "deleted_at", precision: nil
      t.bigint "migration_id"
      t.boolean "default", default: false
      t.string "uuid"
      t.boolean "hidden", default: false
      t.integer "managed_by", default: 0
      t.index ["migration_id"], name: "index_column_definitions_on_migration_id"
      t.index ["relation_id"], name: "index_column_definitions_on_relation_id"
      t.index ["table_definition_id"], name: "index_column_definitions_on_table_definition_id"
    end
  
    create_table "comments", force: :cascade do |t|
      t.bigint "user_id", null: false
      t.bigint "project_id", null: false
      t.string "commentable_type"
      t.bigint "commentable_id"
      t.bigint "parent_id"
      t.string "source_type"
      t.string "status", default: "unresolved"
      t.string "content_references", default: [], array: true
      t.text "content"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "language_code", default: "en", null: false
      t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
      t.index ["parent_id"], name: "index_comments_on_parent_id"
      t.index ["project_id", "language_code"], name: "index_comments_on_project_id_and_language_code"
      t.index ["project_id"], name: "index_comments_on_project_id"
      t.index ["source_type"], name: "index_comments_on_source_type"
      t.index ["status"], name: "index_comments_on_status"
      t.index ["user_id"], name: "index_comments_on_user_id"
    end
  
    create_table "companies", force: :cascade do |t|
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.string "name", null: false
      t.integer "number_of_seats"
      t.string "language_code", null: false
      t.boolean "active", default: true, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["uuid"], name: "index_companies_on_uuid"
    end
  
    create_table "company_members", force: :cascade do |t|
      t.bigint "company_id", null: false
      t.bigint "user_id"
      t.string "role", null: false
      t.string "status", null: false
      t.string "email", null: false
      t.text "invitation_token", null: false
      t.datetime "invited_at", null: false
      t.datetime "accepted_at"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.uuid "uuid", default: -> { "gen_random_uuid()" }
      t.index "lower((email)::text)", name: "index_company_members_on_LOWER_email", unique: true
      t.index ["company_id"], name: "index_company_members_on_company_id"
      t.index ["user_id"], name: "index_company_members_on_user_id"
      t.index ["uuid"], name: "index_company_members_on_uuid", unique: true
    end
  
    create_table "component_descriptions", force: :cascade do |t|
      t.bigint "component_specification_id", null: false
      t.string "language_code", default: "en", null: false
      t.text "description", null: false
      t.jsonb "values"
      t.text "detail_design"
      t.text "behaviour"
      t.text "functionality"
      t.text "usage_guideline"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "title"
      t.index ["component_specification_id", "language_code"], name: "index_on_spec_id_and_lang_code", unique: true
      t.index ["component_specification_id"], name: "index_component_descriptions_on_component_specification_id"
    end
  
    create_table "component_specification_apis", force: :cascade do |t|
      t.bigint "component_specification_id", null: false
      t.bigint "block_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["block_id"], name: "index_comp_spec_apis_on_block_id"
      t.index ["component_specification_id"], name: "index_comp_spec_on_comp_spec_id"
    end
  
    create_table "component_specifications", force: :cascade do |t|
      t.string "commentable_type", null: false
      t.bigint "commentable_id", null: false
      t.bigint "parent_id"
      t.string "url_with_params"
      t.string "element_type"
      t.string "accessibility"
      t.text "code_snippet"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "project_id"
      t.string "component_type", default: "local"
      t.string "scope", default: "local"
      t.boolean "approved", default: false
      t.index ["commentable_type", "commentable_id"], name: "index_component_specifications_on_commentable"
      t.index ["parent_id"], name: "index_component_specifications_on_parent_id"
      t.index ["project_id"], name: "index_component_specifications_on_project_id"
    end
  
    create_table "configurations", force: :cascade do |t|
      t.string "key", null: false
      t.boolean "secured", default: true
      t.integer "order", null: false
      t.bigint "feature_id", null: false
      t.string "label", null: false
      t.text "description", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "storage", default: 0
      t.boolean "is_required", default: true
      t.string "parent_key"
      t.string "value_type", default: "string", null: false
      t.json "validations"
      t.string "default_value"
      t.boolean "cross_environment", default: false
      t.text "dropdown_options"
      t.string "tooltip"
      t.index ["feature_id"], name: "index_configurations_on_feature_id"
      t.index ["key", "feature_id"], name: "index_configurations_on_key_and_feature_id", unique: true
    end
  
    create_table "dashboard_display_params", force: :cascade do |t|
      t.bigint "dashboard_id", null: false
      t.bigint "column_definition_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["column_definition_id"], name: "index_dashboard_display_params_on_column_definition_id"
      t.index ["dashboard_id"], name: "index_dashboard_display_params_on_dashboard_id"
    end
  
    create_table "dashboards", force: :cascade do |t|
      t.bigint "table_definition_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "dashboard_type", null: false
      t.index ["table_definition_id"], name: "index_dashboards_on_table_definition_id"
    end
  
    create_table "data_migrations", primary_key: "version", id: :string, force: :cascade do |t|
    end
  
    create_table "deployments", force: :cascade do |t|
      t.integer "status", default: 0
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "maintainance", default: false
      t.index ["project_id"], name: "index_deployments_on_project_id"
    end
  
    create_table "development_plans", force: :cascade do |t|
      t.string "name"
      t.string "group"
      t.string "source_type"
      t.bigint "source_id"
      t.bigint "parent_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["parent_id"], name: "index_development_plans_on_parent_id"
      t.index ["source_type", "source_id"], name: "index_development_plans_on_source"
    end
  
    create_table "documents", force: :cascade do |t|
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.bigint "project_id"
      t.string "title", limit: 255, null: false
      t.text "content"
      t.jsonb "properties", default: {}
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_documents_on_project_id"
      t.index ["properties"], name: "index_documents_on_properties", using: :gin
      t.index ["title"], name: "index_documents_on_title"
      t.index ["uuid"], name: "index_documents_on_uuid", unique: true
    end
  
    create_table "dump_databases", force: :cascade do |t|
      t.integer "status"
      t.string "key"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "editor_localizations", force: :cascade do |t|
      t.string "key", null: false
      t.string "value"
      t.integer "app_type", default: 0
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id", "app_type", "key"], name: "index_editor_localizations_on_project_id_and_app_type_and_key", unique: true
      t.index ["project_id"], name: "index_editor_localizations_on_project_id"
    end
  
    create_table "enum_values", force: :cascade do |t|
      t.bigint "column_definition_id", null: false
      t.string "name", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["column_definition_id"], name: "index_enum_values_on_column_definition_id"
    end
  
    create_table "feature_actions", force: :cascade do |t|
      t.string "name"
      t.bigint "feature_id", null: false
      t.integer "request_type", default: 0, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "end_point"
      t.boolean "writable", default: true
      t.string "description"
      t.index ["feature_id"], name: "index_feature_actions_on_feature_id"
    end
  
    create_table "feature_configs", force: :cascade do |t|
      t.bigint "project_feature_id"
      t.string "key", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "configuration_id"
      t.integer "env", default: 0
      t.string "value"
      t.index ["configuration_id"], name: "index_feature_configs_on_configuration_id"
      t.index ["key", "project_feature_id", "env"], name: "index_feature_configs_on_key_and_project_feature_id_and_env", unique: true
      t.index ["project_feature_id"], name: "index_feature_configs_on_project_feature_id"
    end
  
    create_table "feature_functions", force: :cascade do |t|
      t.string "name"
      t.bigint "project_feature_id"
      t.bigint "feature_action_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "next_function_type"
      t.bigint "next_function_id"
      t.index ["feature_action_id"], name: "index_feature_functions_on_feature_action_id"
      t.index ["next_function_type", "next_function_id"], name: "index_feature_functions_on_next_function"
      t.index ["project_feature_id"], name: "index_feature_functions_on_project_feature_id"
    end
  
    create_table "feature_operations", force: :cascade do |t|
      t.integer "order", default: 0
      t.bigint "project_feature_id"
      t.bigint "operation_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["operation_id"], name: "index_feature_operations_on_operation_id"
      t.index ["project_feature_id"], name: "index_feature_operations_on_project_feature_id"
    end
  
    create_table "feature_tables", force: :cascade do |t|
      t.bigint "feature_id", null: false
      t.string "name", null: false
      t.text "description", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "multiple", default: true
      t.bigint "operation_id"
      t.index ["feature_id", "name"], name: "index_feature_tables_on_feature_id_and_name", unique: true
      t.index ["feature_id"], name: "index_feature_tables_on_feature_id"
      t.index ["operation_id"], name: "index_feature_tables_on_operation_id"
    end
  
    create_table "feature_toggles", force: :cascade do |t|
      t.string "key", null: false
      t.integer "status", default: 0, null: false
      t.text "description"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.datetime "released_date"
      t.string "version"
      t.index ["key"], name: "index_feature_toggles_on_key", unique: true
    end
  
    create_table "feature_whitelists", force: :cascade do |t|
      t.bigint "feature_toggle_id", null: false
      t.string "target_type", null: false
      t.bigint "target_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.jsonb "metadata", default: {}
      t.index "((metadata ->> 'approved_at'::text))", name: "index_feature_whitelist_metadata_approved_at"
      t.index "((metadata ->> 'events'::text))", name: "index_feature_whitelist_metadata_events"
      t.index "((metadata ->> 'requested_at'::text))", name: "index_feature_whitelist_metadata_requested_at"
      t.index "((metadata ->> 'status'::text))", name: "index_feature_whitelist_metadata_status"
      t.index ["feature_toggle_id"], name: "index_feature_whitelists_on_feature_toggle_id"
      t.index ["target_type", "target_id"], name: "index_feature_whitelists_on_target"
    end
  
    create_table "features", force: :cascade do |t|
      t.string "name", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "default", default: false
      t.string "key"
      t.string "envs"
      t.text "description"
      t.string "platforms"
      t.integer "parent_id"
      t.text "full_description"
      t.string "document_link"
      t.integer "order"
      t.boolean "is_ai", default: false
      t.index ["key"], name: "index_features_on_key", unique: true
      t.index ["parent_id"], name: "index_features_on_parent_id"
    end
  
    create_table "feedbacks", force: :cascade do |t|
      t.text "description"
      t.integer "contact_type", default: 0, null: false
      t.string "os_version"
      t.string "browser_version"
      t.string "environment"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "form_inputs", force: :cascade do |t|
      t.bigint "mobile_app_page_id", null: false
      t.bigint "column_definition_id", null: false
      t.string "label"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["column_definition_id"], name: "index_form_inputs_on_column_definition_id"
      t.index ["mobile_app_page_id"], name: "index_form_inputs_on_mobile_app_page_id"
    end
  
    create_table "friendly_id_slugs", force: :cascade do |t|
      t.string "slug", null: false
      t.integer "sluggable_id", null: false
      t.string "sluggable_type", limit: 50
      t.string "scope"
      t.datetime "created_at"
      t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
      t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
      t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
    end
  
    create_table "function_arguments", force: :cascade do |t|
      t.string "argument_of_function_type"
      t.bigint "argument_of_function_id"
      t.bigint "argument_id", null: false
      t.string "mapping_value_type"
      t.bigint "mapping_value_id"
      t.string "method_on_mapping_value_type"
      t.bigint "method_on_mapping_value_id"
      t.string "internal_mapping_type"
      t.bigint "internal_mapping_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["argument_id"], name: "index_function_arguments_on_argument_id"
      t.index ["argument_of_function_type", "argument_of_function_id"], name: "index_function_arguments_on_argument_of_function"
      t.index ["internal_mapping_type", "internal_mapping_id"], name: "index_function_arguments_on_internal_mapping"
      t.index ["mapping_value_type", "mapping_value_id"], name: "index_function_arguments_on_mapping_value"
      t.index ["method_on_mapping_value_type", "method_on_mapping_value_id"], name: "index_function_arguments_on_method_on_mapping_value"
    end
  
    create_table "git_commit_shas", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.bigint "project_import_id", null: false
      t.jsonb "shas", default: [], null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_git_commit_shas_on_project_id"
      t.index ["project_import_id"], name: "index_git_commit_shas_on_project_import_id"
    end
  
    create_table "git_providers", force: :cascade do |t|
      t.string "name", null: false
      t.string "display_name"
      t.text "description"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "provider", default: 0
    end
  
    create_table "git_providers_users", force: :cascade do |t|
      t.bigint "user_id", null: false
      t.bigint "git_provider_id", null: false
      t.string "email"
      t.string "name"
      t.datetime "expires_at"
      t.text "token", null: false
      t.text "refresh_token"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["git_provider_id"], name: "index_git_providers_users_on_git_provider_id"
      t.index ["user_id"], name: "index_git_providers_users_on_user_id"
    end
  
    create_table "git_pull_requests", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.string "block_node_id"
      t.string "status", default: "pending", null: false
      t.string "owner_name", null: false
      t.string "repository_name", null: false
      t.string "branch_name", null: false
      t.integer "pull_request_number"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "category", default: "erd"
      t.bigint "development_plan_id"
      t.bigint "project_source_id"
      t.string "name"
      t.index ["development_plan_id"], name: "index_git_pull_requests_on_development_plan_id"
      t.index ["project_id"], name: "index_git_pull_requests_on_project_id"
      t.index ["project_source_id"], name: "index_git_pull_requests_on_project_source_id"
    end
  
    create_table "groups", force: :cascade do |t|
      t.string "title"
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_groups_on_project_id"
      t.index ["title", "project_id"], name: "index_groups_on_title_and_project_id", unique: true
    end
  
    create_table "hosted_zones", force: :cascade do |t|
      t.string "domain"
      t.text "named_servers"
      t.bigint "organization_id", null: false
      t.integer "status"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["organization_id"], name: "index_hosted_zones_on_organization_id"
    end
  
    create_table "hubspot_providers", force: :cascade do |t|
      t.text "token", null: false
      t.text "refresh_token", null: false
      t.integer "expires_at", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "idp_configs", force: :cascade do |t|
      t.string "assertion_consumer_service_url", null: false
      t.string "assertion_consumer_service_binding"
      t.string "name_identifier_format"
      t.string "issuer", null: false
      t.string "idp_entity_id", null: false
      t.string "authn_context"
      t.string "idp_slo_service_url"
      t.string "idp_sso_service_url", null: false
      t.string "idp_cert_fingerprint", null: false
      t.string "idp_tenant_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "idp_tenants", force: :cascade do |t|
      t.string "domains", default: [], null: false, array: true
      t.integer "provider", null: false
      t.boolean "enabled", default: true, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "scim_token"
      t.string "subscription_plan"
    end
  
    create_table "invitations", force: :cascade do |t|
      t.bigint "user_id", null: false
      t.string "status", default: "pending", null: false
      t.string "email", null: false
      t.bigint "project_id", null: false
      t.datetime "expired_at", null: false
      t.string "token", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_invitations_on_project_id"
      t.index ["token"], name: "index_invitations_on_token", unique: true
      t.index ["user_id"], name: "index_invitations_on_user_id"
    end
  
    create_table "invoices", force: :cascade do |t|
      t.string "from_name"
      t.string "to_name"
      t.string "from_email"
      t.string "to_email"
      t.string "to_company"
      t.integer "status", default: 0
      t.boolean "recurring", default: true
      t.integer "recurring_interval", default: 0
      t.string "plan_name", null: false
      t.integer "number_of_seat"
      t.integer "unit_amount", null: false
      t.integer "discount"
      t.integer "currency", default: 0
      t.integer "language", default: 0
      t.string "slug", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "subscription_price_id"
      t.string "uuid"
      t.string "invoice_number"
      t.string "invoice_id"
      t.index ["invoice_number"], name: "index_invoices_on_invoice_number", unique: true
      t.index ["slug"], name: "index_invoices_on_slug", unique: true
    end
  
    create_table "ips", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.string "address", null: false
      t.integer "env", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_ips_on_project_id"
    end
  
    create_table "jira_projects", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.string "jira_id", null: false
      t.string "name", null: false
      t.string "key", null: false
      t.bigint "jira_token_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "web_hook_id"
      t.index ["jira_token_id"], name: "index_jira_projects_on_jira_token_id"
      t.index ["project_id"], name: "index_jira_projects_on_project_id"
    end
  
    create_table "jira_tickets", force: :cascade do |t|
      t.string "jira_ticket_id"
      t.bigint "jira_project_id", null: false
      t.bigint "project_id", null: false
      t.bigint "block_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["block_id"], name: "index_jira_tickets_on_block_id"
      t.index ["jira_project_id"], name: "index_jira_tickets_on_jira_project_id"
      t.index ["project_id"], name: "index_jira_tickets_on_project_id"
    end
  
    create_table "jira_tokens", force: :cascade do |t|
      t.string "access_token"
      t.string "refresh_token"
      t.integer "status", default: 0
      t.datetime "expires_at"
      t.string "scope"
      t.bigint "user_id", null: false
      t.bigint "project_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "resource_id"
      t.index ["project_id"], name: "index_jira_tokens_on_project_id"
      t.index ["user_id"], name: "index_jira_tokens_on_user_id"
    end
  
    create_table "languages", force: :cascade do |t|
      t.string "code", null: false
      t.string "name", null: false
      t.string "native_name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["code"], name: "index_languages_on_code", unique: true
    end
  
    create_table "llms", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.string "name", null: false
      t.string "provider", null: false
      t.string "model_key", null: false
      t.boolean "is_default", default: false
      t.boolean "enabled", default: false
      t.string "version"
      t.jsonb "metadata"
      t.boolean "disabled", default: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "localizations", force: :cascade do |t|
      t.string "key", null: false
      t.text "value"
      t.string "item_type"
      t.bigint "item_id"
      t.integer "locale_layer"
      t.integer "locale_type"
      t.bigint "language_id", null: false
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "display_key"
      t.string "mongo_item_id"
      t.string "ref_id"
      t.index ["item_type", "item_id"], name: "index_localizations_on_item"
      t.index ["language_id"], name: "index_localizations_on_language_id"
      t.index ["project_id", "language_id", "locale_layer", "key"], name: "idx_localizations_on_project_id_language_id_locale_layer_key", unique: true
      t.index ["project_id"], name: "index_localizations_on_project_id"
    end
  
    create_table "mapping_locations", force: :cascade do |t|
      t.bigint "component_specification_id", null: false
      t.string "type", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.float "top"
      t.float "left"
      t.float "right"
      t.float "bottom"
      t.index ["component_specification_id"], name: "index_mapping_locations_on_component_specification_id"
      t.index ["type"], name: "index_mapping_locations_on_type"
    end
  
    create_table "members", force: :cascade do |t|
      t.bigint "organisation_id", null: false
      t.bigint "user_id", null: false
      t.integer "role", default: 0
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.index ["organisation_id", "user_id"], name: "index_members_on_organisation_id_and_user_id", unique: true
      t.index ["organisation_id"], name: "index_members_on_organisation_id"
      t.index ["user_id"], name: "index_members_on_user_id"
      t.index ["uuid"], name: "index_members_on_uuid", unique: true
    end
  
    create_table "messages", force: :cascade do |t|
      t.bigint "user_id", null: false
      t.bigint "chat_id", null: false
      t.string "status", default: "inprogress"
      t.string "assistant"
      t.string "from"
      t.text "content"
      t.jsonb "metadata", default: {}
      t.boolean "hidden", default: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.integer "resources_count", default: 0
      t.integer "total_code_lines", default: 0
      t.index ["chat_id", "created_at"], name: "index_messages_on_chat_id_and_created_at", order: { created_at: :desc }
      t.index ["chat_id"], name: "index_messages_on_chat_id"
      t.index ["content"], name: "index_messages_on_content", opclass: :gin_trgm_ops, using: :gin
      t.index ["from"], name: "index_messages_on_from"
      t.index ["user_id"], name: "index_messages_on_user_id"
      t.index ["uuid"], name: "index_messages_on_uuid", unique: true
    end
  
    create_table "migrations", force: :cascade do |t|
      t.string "uuid", null: false
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_migrations_on_project_id"
      t.index ["uuid"], name: "index_migrations_on_uuid"
    end
  
    create_table "mobile_app_page_links", force: :cascade do |t|
      t.bigint "mobile_app_page_id", null: false
      t.bigint "to_page_id"
      t.string "label", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "link_type", default: 0, null: false
      t.index ["mobile_app_page_id"], name: "index_mobile_app_page_links_on_mobile_app_page_id"
      t.index ["to_page_id"], name: "index_mobile_app_page_links_on_to_page_id"
    end
  
    create_table "mobile_app_pages", force: :cascade do |t|
      t.bigint "table_definition_id"
      t.integer "page_type"
      t.string "title"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "parent_id"
      t.integer "nav_type"
      t.string "page_name", null: false
      t.bigint "project_id"
      t.bigint "list_item_title_column_id"
      t.bigint "list_item_description_column_id"
      t.bigint "list_item_sub_description_column_id"
      t.bigint "list_item_thumbnail_column_id"
      t.bigint "detail_top_image_column_id"
      t.bigint "detail_title_column_id"
      t.string "tab_icon"
      t.string "tab_label"
      t.boolean "require_session"
      t.bigint "detail_title_thumbnail_column_id"
      t.bigint "detail_sub_title_column_id"
      t.bigint "detail_body_column_id"
      t.bigint "form_api_id"
      t.bigint "mounted_api_id"
      t.bigint "redirect_after_request_page_id"
      t.bigint "list_item_linked_page_id"
      t.text "markdown"
      t.boolean "backable"
      t.json "mobile_file"
      t.text "mobile_file_raw"
      t.index ["form_api_id"], name: "index_mobile_app_pages_on_form_api_id"
      t.index ["list_item_linked_page_id"], name: "index_mobile_app_pages_on_list_item_linked_page_id"
      t.index ["mounted_api_id"], name: "index_mobile_app_pages_on_mounted_api_id"
      t.index ["project_id"], name: "index_mobile_app_pages_on_project_id"
      t.index ["redirect_after_request_page_id"], name: "index_mobile_app_pages_on_redirect_after_request_page_id"
      t.index ["table_definition_id"], name: "index_mobile_app_pages_on_table_definition_id"
    end
  
    create_table "mobile_molecules", force: :cascade do |t|
      t.json "data"
      t.bigint "project_id"
      t.text "data_raw"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_mobile_molecules_on_project_id"
    end
  
    create_table "mobile_navigations", force: :cascade do |t|
      t.json "data"
      t.bigint "project_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.text "data_raw"
      t.index ["project_id"], name: "index_mobile_navigations_on_project_id"
    end
  
    create_table "model_functions", force: :cascade do |t|
      t.string "name", null: false
      t.bigint "table_definition_id"
      t.integer "action"
      t.string "next_function_type"
      t.bigint "next_function_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "project_id"
      t.string "calling_function_type"
      t.bigint "calling_function_id"
      t.index ["calling_function_type", "calling_function_id"], name: "index_model_functions_on_calling_function"
      t.index ["next_function_type", "next_function_id"], name: "index_model_functions_on_next_function"
      t.index ["project_id"], name: "index_model_functions_on_project_id"
      t.index ["table_definition_id"], name: "index_model_functions_on_table_definition_id"
    end
  
    create_table "module_requests", force: :cascade do |t|
      t.text "description", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "user_id"
      t.bigint "project_id"
      t.index ["project_id"], name: "index_module_requests_on_project_id"
      t.index ["user_id"], name: "index_module_requests_on_user_id"
    end
  
    create_table "notifications", force: :cascade do |t|
      t.string "notification_type", null: false
      t.string "screen_name", null: false
      t.string "title", null: false
      t.text "content", null: false
      t.bigint "project_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_notifications_on_project_id"
    end
  
    create_table "oauth_access_grants", force: :cascade do |t|
      t.bigint "resource_owner_id", null: false
      t.bigint "application_id", null: false
      t.string "token", null: false
      t.integer "expires_in", null: false
      t.text "redirect_uri", null: false
      t.datetime "created_at", null: false
      t.datetime "revoked_at"
      t.string "scopes", default: "", null: false
      t.string "resource_owner_type", null: false
      t.index ["application_id"], name: "index_oauth_access_grants_on_application_id"
      t.index ["resource_owner_id", "resource_owner_type"], name: "polymorphic_owner_oauth_access_grants"
      t.index ["resource_owner_id"], name: "index_oauth_access_grants_on_resource_owner_id"
      t.index ["token"], name: "index_oauth_access_grants_on_token", unique: true
    end
  
    create_table "oauth_access_tokens", force: :cascade do |t|
      t.bigint "resource_owner_id"
      t.bigint "application_id", null: false
      t.string "token", null: false
      t.string "refresh_token"
      t.integer "expires_in"
      t.datetime "revoked_at"
      t.datetime "created_at", null: false
      t.string "scopes"
      t.string "previous_refresh_token", default: "", null: false
      t.string "resource_owner_type"
      t.integer "refresh_expires_in"
      t.index ["application_id"], name: "index_oauth_access_tokens_on_application_id"
      t.index ["refresh_token"], name: "index_oauth_access_tokens_on_refresh_token", unique: true
      t.index ["resource_owner_id", "resource_owner_type"], name: "polymorphic_owner_oauth_access_tokens"
      t.index ["resource_owner_id"], name: "index_oauth_access_tokens_on_resource_owner_id"
      t.index ["token"], name: "index_oauth_access_tokens_on_token", unique: true
    end
  
    create_table "oauth_applications", force: :cascade do |t|
      t.string "name", null: false
      t.string "uid", null: false
      t.string "secret", null: false
      t.text "redirect_uri"
      t.string "scopes", default: "", null: false
      t.boolean "confidential", default: true, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["uid"], name: "index_oauth_applications_on_uid", unique: true
    end
  
    create_table "operations", force: :cascade do |t|
      t.string "name", null: false
      t.bigint "feature_id", null: false
      t.integer "order", default: 0
      t.boolean "default", default: true
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["feature_id"], name: "index_operations_on_feature_id"
    end
  
    create_table "order_params", force: :cascade do |t|
      t.integer "owner_of_order_id"
      t.bigint "column_definition_id"
      t.integer "type_of_order"
      t.string "type"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["column_definition_id"], name: "index_order_params_on_column_definition_id"
    end
  
    create_table "organisation_invitations", force: :cascade do |t|
      t.string "email", null: false
      t.integer "status", default: 0
      t.datetime "expired_at", null: false
      t.string "token", null: false
      t.bigint "sender_id"
      t.bigint "user_id"
      t.bigint "organisation_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "role", default: 0, null: false
      t.index ["organisation_id"], name: "index_organisation_invitations_on_organisation_id"
      t.index ["token"], name: "index_organisation_invitations_on_token", unique: true
    end
  
    create_table "organisations", force: :cascade do |t|
      t.string "name"
      t.string "slug", null: false
      t.string "stripe_customer_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.datetime "deleted_at"
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.integer "organisation_type", default: 0
      t.decimal "total_tokens", precision: 10, scale: 2, default: "0.0"
      t.integer "source_from", default: 0
      t.string "hubspot_property_team_index"
      t.text "allowed_ips", default: [], array: true
      t.boolean "enable_ip_restrict", default: false
      t.bigint "company_id"
      t.index ["company_id"], name: "index_organisations_on_company_id"
      t.index ["slug"], name: "index_organisations_on_slug", unique: true
      t.index ["uuid"], name: "index_organisations_on_uuid", unique: true
    end
  
    create_table "organizations", force: :cascade do |t|
      t.string "email", null: false
      t.string "name", null: false
      t.string "account_number"
      t.bigint "user_id", null: false
      t.bigint "project_id", null: false
      t.integer "status", default: 0, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "env", default: 0, null: false
      t.index ["email"], name: "index_organizations_on_email", unique: true
      t.index ["env", "project_id"], name: "index_organizations_on_env_and_project_id", unique: true
      t.index ["name", "project_id"], name: "index_organizations_on_name_and_project_id", unique: true
      t.index ["project_id"], name: "index_organizations_on_project_id"
      t.index ["user_id"], name: "index_organizations_on_user_id"
    end
  
    create_table "outputs", force: :cascade do |t|
      t.string "function_type"
      t.bigint "function_id"
      t.string "reference_type"
      t.bigint "reference_id"
      t.integer "category"
      t.integer "data_type"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "variable_name"
      t.boolean "required", default: true
      t.bigint "parent_id"
      t.index ["function_type", "function_id"], name: "index_outputs_on_function"
      t.index ["parent_id"], name: "index_outputs_on_parent_id"
      t.index ["reference_type", "reference_id"], name: "index_outputs_on_reference"
    end
  
    create_table "paginations", force: :cascade do |t|
      t.string "paginable_type"
      t.bigint "paginable_id"
      t.string "page_reference_type"
      t.bigint "page_reference_id"
      t.string "limit_reference_type"
      t.bigint "limit_reference_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["limit_reference_type", "limit_reference_id"], name: "index_paginations_on_limit_reference"
      t.index ["page_reference_type", "page_reference_id"], name: "index_paginations_on_page_reference"
      t.index ["paginable_type", "paginable_id"], name: "index_paginations_on_paginable"
    end
  
    create_table "payment_methods", force: :cascade do |t|
      t.bigint "organisation_id", null: false
      t.string "status"
      t.string "last_four_digits"
      t.string "card_brand"
      t.string "payment_method_id", null: false
      t.boolean "default", default: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "exp_month"
      t.integer "exp_year"
      t.index ["organisation_id"], name: "index_payment_methods_on_organisation_id"
    end
  
    create_table "payments", force: :cascade do |t|
      t.bigint "organisation_id", null: false
      t.bigint "user_id", null: false
      t.integer "tokens"
      t.decimal "price"
      t.string "status"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "currency"
      t.json "stripe_response"
      t.string "stripe_invoice_id"
      t.integer "failed_attempt_count", default: 0, null: false
      t.integer "seat_count", default: 0, null: false
      t.index ["organisation_id"], name: "index_payments_on_organisation_id"
      t.index ["user_id"], name: "index_payments_on_user_id"
    end
  
    create_table "plugin_configs", force: :cascade do |t|
      t.string "key"
      t.string "label"
      t.string "default_value"
      t.string "value_type"
      t.text "description"
      t.integer "order", default: 0
      t.integer "storage", default: 0
      t.jsonb "dropdown_options", default: {}
      t.jsonb "validations", default: {}
      t.boolean "required", default: true
      t.bigint "plugin_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["plugin_id"], name: "index_plugin_configs_on_plugin_id"
    end
  
    create_table "plugins", force: :cascade do |t|
      t.string "name"
      t.string "key"
      t.text "description"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["key"], name: "index_plugins_on_key", unique: true
    end
  
    create_table "project_assets", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.integer "app_type", default: 0, null: false
      t.bigint "previous_asset_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "name"
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.index ["project_id"], name: "index_project_assets_on_project_id"
      t.index ["uuid"], name: "index_project_assets_on_uuid", unique: true
    end
  
    create_table "project_block_changes", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.integer "status", default: 0, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.jsonb "block_node_ids", default: {}, null: false
      t.string "event", null: false
      t.index ["project_id"], name: "index_project_block_changes_on_project_id"
    end
  
    create_table "project_connect_notions", force: :cascade do |t|
      t.bigint "project_notion_provider_id", null: false
      t.integer "status", default: 0, null: false
      t.string "error_message"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_notion_provider_id"], name: "index_project_connect_notions_on_project_notion_provider_id"
    end
  
    create_table "project_document_changes", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.string "event", null: false
      t.integer "status", default: 0
      t.jsonb "document_metadata", default: {}
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id", "event"], name: "index_project_document_changes_on_project_id_and_event"
      t.index ["project_id", "status"], name: "index_project_document_changes_on_project_id_and_status"
      t.index ["project_id"], name: "index_project_document_changes_on_project_id"
    end
  
    create_table "project_exports", force: :cascade do |t|
      t.string "job_id"
      t.integer "status", default: 0
      t.integer "export_type"
      t.integer "progress", default: 0
      t.text "error_message"
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "progress_message"
      t.integer "target", default: 0
      t.string "branch_name"
      t.bigint "project_source_id"
      t.jsonb "metadata"
      t.bigint "project_generate_queue_id"
      t.bigint "project_generate_id"
      t.index ["project_generate_id"], name: "index_project_exports_on_project_generate_id"
      t.index ["project_generate_queue_id"], name: "index_project_exports_on_project_generate_queue_id"
      t.index ["project_id"], name: "index_project_exports_on_project_id"
      t.index ["project_source_id"], name: "index_project_exports_on_project_source_id"
    end
  
    create_table "project_feature_api_functions", force: :cascade do |t|
      t.bigint "project_feature_id"
      t.bigint "api_function_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["api_function_id"], name: "index_project_feature_api_functions_on_api_function_id"
      t.index ["project_feature_id"], name: "index_project_feature_api_functions_on_project_feature_id"
    end
  
    create_table "project_feature_migrations", force: :cascade do |t|
      t.bigint "project_feature_id"
      t.string "migration_name", null: false
      t.string "migration_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_feature_id"], name: "index_project_feature_migrations_on_project_feature_id"
    end
  
    create_table "project_feature_tables", force: :cascade do |t|
      t.bigint "feature_table_id", null: false
      t.bigint "table_definition_id", null: false
      t.bigint "project_feature_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["feature_table_id"], name: "index_project_feature_tables_on_feature_table_id"
      t.index ["project_feature_id"], name: "index_project_feature_tables_on_project_feature_id"
      t.index ["table_definition_id"], name: "index_project_feature_tables_on_table_definition_id"
    end
  
    create_table "project_features", force: :cascade do |t|
      t.bigint "feature_id", null: false
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "name", null: false
      t.string "envs"
      t.index ["feature_id"], name: "index_project_features_on_feature_id"
      t.index ["project_id"], name: "index_project_features_on_project_id"
    end
  
    create_table "project_feedbacks", force: :cascade do |t|
      t.string "sourceable_type", null: false
      t.bigint "sourceable_id", null: false
      t.bigint "user_id", null: false
      t.bigint "project_id", null: false
      t.string "reaction_type", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.jsonb "metadata", default: {}
      t.index ["project_id"], name: "index_project_feedbacks_on_project_id"
      t.index ["sourceable_type", "sourceable_id"], name: "index_project_feedbacks_on_sourceable"
      t.index ["user_id"], name: "index_project_feedbacks_on_user_id"
      t.index ["uuid"], name: "index_project_feedbacks_on_uuid", unique: true
    end
  
    create_table "project_figma_files", force: :cascade do |t|
      t.string "name"
      t.string "node_id"
      t.bigint "project_id", null: false
      t.bigint "project_figma_import_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_figma_import_id"], name: "index_project_figma_files_on_project_figma_import_id"
      t.index ["project_id"], name: "index_project_figma_files_on_project_id"
    end
  
    create_table "project_figma_imports", force: :cascade do |t|
      t.string "link", null: false
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "node_ids"
      t.string "file_key"
      t.index ["project_id"], name: "index_project_figma_imports_on_project_id"
    end
  
    create_table "project_figma_providers", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.string "token", null: false
      t.string "refresh_token", null: false
      t.integer "expires_at", null: false
      t.bigint "user_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_project_figma_providers_on_project_id"
      t.index ["user_id"], name: "index_project_figma_providers_on_user_id"
    end
  
    create_table "project_generate_action_chunks", force: :cascade do |t|
      t.bigint "project_generate_action_id"
      t.integer "status", default: 0, null: false
      t.jsonb "items", default: [], null: false
      t.string "error_message"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_generate_action_id"], name: "pr_gen_action_chunk_on_pr_gen"
      t.index ["status"], name: "index_project_generate_action_chunks_on_status"
    end
  
    create_table "project_generate_action_versions", force: :cascade do |t|
      t.string "item_type", null: false
      t.bigint "item_id", null: false
      t.string "event", null: false
      t.string "whodunnit"
      t.jsonb "object"
      t.jsonb "object_changes"
      t.datetime "created_at"
      t.index ["item_type", "item_id"], name: "index_project_generate_action_versions_on_item_type_and_item_id"
    end
  
    create_table "project_generate_actions", force: :cascade do |t|
      t.integer "status", default: 0
      t.string "action_type", default: "0"
      t.text "error_messages"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "project_generate_id"
      t.jsonb "metadata", default: {}
      t.integer "total_chunks", default: 0
      t.index ["project_generate_id"], name: "index_project_generate_actions_on_project_generate_id"
    end
  
    create_table "project_generate_versions", force: :cascade do |t|
      t.string "item_type", null: false
      t.bigint "item_id", null: false
      t.string "event", null: false
      t.string "whodunnit"
      t.datetime "created_at"
      t.jsonb "object_changes"
      t.jsonb "object"
      t.index ["item_type", "item_id"], name: "index_project_generate_versions_on_item_type_and_item_id"
    end
  
    create_table "project_generates", force: :cascade do |t|
      t.integer "status", default: 0
      t.string "progress_message"
      t.text "error_message"
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "project_source_id"
      t.jsonb "metadata", default: {}
      t.integer "progress", default: 0
      t.string "source_type"
      t.bigint "source_id"
      t.integer "generate_type", default: 0
      t.bigint "parent_id"
      t.integer "estimated_time"
      t.integer "git_pull_request_id"
      t.text "users_prompt", default: ""
      t.index ["parent_id"], name: "index_project_generates_on_parent_id"
      t.index ["project_id"], name: "index_project_generates_on_project_id"
      t.index ["project_source_id"], name: "index_project_generates_on_project_source_id"
      t.index ["source_type", "source_id"], name: "index_project_generates_on_source"
    end
  
    create_table "project_git_changes", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.integer "status"
      t.jsonb "data", default: {}
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "project_source_id"
      t.boolean "is_index", default: false
      t.boolean "is_conflict", default: false
      t.boolean "is_document_generated", default: false
      t.boolean "is_erd_generated", default: false
      t.index ["project_id"], name: "index_project_git_changes_on_project_id"
    end
  
    create_table "project_git_hosts", force: :cascade do |t|
      t.bigint "project_id"
      t.string "provider"
      t.string "url", null: false
      t.string "token", null: false
      t.bigint "user_id", null: false
      t.string "client_id", null: false
      t.string "client_secret", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_project_git_hosts_on_project_id"
      t.index ["user_id"], name: "index_project_git_hosts_on_user_id"
    end
  
    create_table "project_git_provider_versions", force: :cascade do |t|
      t.string "item_type", null: false
      t.bigint "item_id", null: false
      t.string "event", null: false
      t.string "whodunnit"
      t.jsonb "object"
      t.jsonb "object_changes"
      t.datetime "created_at"
      t.index ["item_type", "item_id"], name: "index_project_git_provider_versions_on_item_type_and_item_id"
    end
  
    create_table "project_git_providers", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.integer "provider", default: 0, null: false
      t.text "token", null: false
      t.text "refresh_token", null: false
      t.integer "expires_at", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "user_id", null: false
      t.bigint "project_git_host_id"
      t.integer "status", default: 0
      t.index ["project_git_host_id"], name: "index_project_git_providers_on_project_git_host_id"
      t.index ["project_id"], name: "index_project_git_providers_on_project_id"
      t.index ["user_id"], name: "index_project_git_providers_on_user_id"
    end
  
    create_table "project_git_repositories", force: :cascade do |t|
      t.bigint "project_git_provider_id", null: false
      t.string "name", null: false
      t.string "description"
      t.text "info"
      t.integer "status", default: 0, null: false
      t.integer "project_target", default: 0, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_git_provider_id"], name: "index_project_git_repositories_on_project_git_provider_id"
    end
  
    create_table "project_html_screens", force: :cascade do |t|
      t.string "name"
      t.text "html"
      t.json "data"
      t.string "source", default: ""
      t.string "status", default: "created", null: false
      t.bigint "block_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["block_id"], name: "index_project_html_screens_on_block_id"
    end
  
    create_table "project_import_page_actions", force: :cascade do |t|
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.string "actionable_type", null: false
      t.bigint "actionable_id", null: false
      t.string "name", null: false
      t.text "script"
      t.string "action_type"
      t.string "url"
      t.string "dynamic_path"
      t.string "selector"
      t.jsonb "inputs", default: []
      t.text "files", default: [], array: true
      t.text "description"
      t.text "logic_description"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["actionable_type", "actionable_id"], name: "index_project_import_page_actions_on_actionable"
      t.index ["uuid"], name: "index_project_import_page_actions_on_uuid"
    end
  
    create_table "project_import_page_components", force: :cascade do |t|
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.integer "project_import_page_id", null: false
      t.string "name", null: false
      t.text "html"
      t.text "script"
      t.string "parent"
      t.string "screenshot"
      t.text "description"
      t.text "logic_description"
      t.jsonb "size", default: {}
      t.jsonb "position", default: {}
      t.jsonb "elements", default: []
      t.text "files", default: [], array: true
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "code"
      t.string "component"
      t.string "component_import"
      t.boolean "direct_element"
      t.string "file"
      t.integer "lines", array: true
      t.jsonb "sources", array: true
      t.string "translation_keys", default: [], array: true
      t.index ["project_import_page_id"], name: "index_project_import_page_components_on_project_import_page_id"
      t.index ["uuid"], name: "index_project_import_page_components_on_uuid"
    end
  
    create_table "project_import_pages", force: :cascade do |t|
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.bigint "project_id", null: false
      t.bigint "project_source_id"
      t.string "url", null: false
      t.string "name"
      t.string "path"
      t.string "parent_url"
      t.string "dynamic_path"
      t.text "html"
      t.jsonb "size"
      t.text "files", default: [], array: true
      t.text "description"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "state"
      t.integer "version"
      t.jsonb "elements", default: []
      t.jsonb "metadata", default: {}
      t.string "file"
      t.index ["project_id"], name: "index_project_import_pages_on_project_id"
      t.index ["project_source_id"], name: "index_project_import_pages_on_project_source_id"
      t.index ["uuid"], name: "index_project_import_pages_on_uuid"
    end
  
    create_table "project_import_translation_contents", force: :cascade do |t|
      t.string "language_code", null: false
      t.text "content", null: false
      t.string "file"
      t.bigint "project_import_translation_key_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_import_translation_key_id"], name: "index_translation_content_on_translation_key_id"
    end
  
    create_table "project_import_translation_files", force: :cascade do |t|
      t.jsonb "file_language_map", default: {}
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_project_import_translation_files_on_project_id"
    end
  
    create_table "project_import_translation_keys", force: :cascade do |t|
      t.string "key", null: false
      t.bigint "project_id", null: false
      t.bigint "project_source_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_project_import_translation_keys_on_project_id"
      t.index ["project_source_id"], name: "index_project_import_translation_keys_on_project_source_id"
    end
  
    create_table "project_imports", force: :cascade do |t|
      t.jsonb "metadata", default: {}
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "owner_name"
      t.string "branch_name"
      t.string "repository_name"
      t.integer "owner_type", default: 0
      t.bigint "project_source_id"
      t.bigint "repository_id"
      t.bigint "owner_id"
      t.index ["owner_id"], name: "index_project_imports_on_owner_id"
      t.index ["project_id"], name: "index_project_imports_on_project_id"
      t.index ["project_source_id"], name: "index_project_imports_on_project_source_id"
      t.index ["repository_id"], name: "index_project_imports_on_repository_id"
    end
  
    create_table "project_languages", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.bigint "language_id", null: false
      t.boolean "default", default: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["language_id"], name: "index_project_languages_on_language_id"
      t.index ["project_id", "language_id"], name: "index_project_languages_on_project_id_and_language_id", unique: true
      t.index ["project_id"], name: "index_project_languages_on_project_id"
    end
  
    create_table "project_migrations", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.string "migration_id", null: false
      t.json "data", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_project_migrations_on_project_id"
    end
  
    create_table "project_notion_imports", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.bigint "user_id", null: false
      t.integer "status"
      t.string "page_ids", default: [], array: true
      t.string "error_message"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_project_notion_imports_on_project_id"
      t.index ["user_id"], name: "index_project_notion_imports_on_user_id"
    end
  
    create_table "project_notion_pages", force: :cascade do |t|
      t.bigint "project_notion_provider_id", null: false
      t.string "page_id"
      t.jsonb "parent", default: {}
      t.string "title"
      t.integer "page_type"
      t.string "creator_name"
      t.datetime "last_edited"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "user_id"
      t.bigint "project_id"
      t.index ["page_id", "project_notion_provider_id"], name: "index_on_page_id_and_project_notion_page_id", unique: true
      t.index ["page_id"], name: "index_project_notion_pages_on_page_id"
      t.index ["project_id"], name: "index_project_notion_pages_on_project_id"
      t.index ["project_notion_provider_id"], name: "index_project_notion_pages_on_project_notion_provider_id"
      t.index ["user_id"], name: "index_project_notion_pages_on_user_id"
    end
  
    create_table "project_notion_providers", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.bigint "user_id", null: false
      t.string "provider", null: false
      t.text "token", null: false
      t.string "owner_name"
      t.string "owner_id"
      t.string "workspace_name"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_project_notion_providers_on_project_id"
      t.index ["user_id"], name: "index_project_notion_providers_on_user_id"
    end
  
    create_table "project_overviews", force: :cascade do |t|
      t.json "data"
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "status", default: 0, null: false
      t.index ["project_id"], name: "index_project_overviews_on_project_id"
      t.index ["project_id"], name: "uniq_project_overviews_on_project_id", unique: true
    end
  
    create_table "project_pdf_imports", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.jsonb "metadata", default: {}
      t.string "language"
      t.integer "status", default: 0, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_project_pdf_imports_on_project_id"
      t.index ["status"], name: "index_project_pdf_imports_on_status"
    end
  
    create_table "project_plugin_configs", force: :cascade do |t|
      t.string "key"
      t.string "value"
      t.bigint "plugin_config_id"
      t.bigint "project_plugin_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["plugin_config_id"], name: "index_project_plugin_configs_on_plugin_config_id"
      t.index ["project_plugin_id"], name: "index_project_plugin_configs_on_project_plugin_id"
    end
  
    create_table "project_plugin_tables", force: :cascade do |t|
      t.bigint "table_definition_id"
      t.bigint "project_plugin_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_plugin_id"], name: "index_project_plugin_tables_on_project_plugin_id"
      t.index ["table_definition_id"], name: "index_project_plugin_tables_on_table_definition_id"
    end
  
    create_table "project_plugins", force: :cascade do |t|
      t.string "name"
      t.string "status", default: "enabled"
      t.bigint "plugin_id"
      t.bigint "project_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["plugin_id"], name: "index_project_plugins_on_plugin_id"
      t.index ["project_id"], name: "index_project_plugins_on_project_id"
    end
  
    create_table "project_previews", force: :cascade do |t|
      t.string "job_id", default: "", null: false
      t.integer "status", default: 0
      t.integer "preview_type"
      t.integer "progress", default: 0
      t.text "progress_message"
      t.text "error_message"
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "external_source_path"
      t.jsonb "metadata", default: {}
      t.string "sourceable_type"
      t.bigint "sourceable_id"
      t.index ["project_id"], name: "index_project_previews_on_project_id"
      t.index ["sourceable_type", "sourceable_id"], name: "index_project_previews_on_sourceable"
    end
  
    create_table "project_screens", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.string "sourceable_type"
      t.bigint "sourceable_id"
      t.bigint "block_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "document_id"
      t.index ["block_id"], name: "index_project_screens_on_block_id"
      t.index ["document_id"], name: "index_project_screens_on_document_id"
      t.index ["project_id"], name: "index_project_screens_on_project_id"
      t.index ["sourceable_type", "sourceable_id"], name: "index_project_screens_on_sourceable"
    end
  
    create_table "project_share_links", force: :cascade do |t|
      t.bigint "project_id"
      t.integer "mode"
      t.string "token", null: false
      t.string "password_digest"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_project_share_links_on_project_id"
    end
  
    create_table "project_shares", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.bigint "user_id", null: false
      t.integer "role", default: 0, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_project_shares_on_project_id"
      t.index ["user_id"], name: "index_project_shares_on_user_id"
    end
  
    create_table "project_source_configurations", force: :cascade do |t|
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.bigint "project_id", null: false
      t.integer "category", default: 0, null: false
      t.string "file_patterns", default: [], array: true
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "auto_discover", default: true, null: false
      t.index ["project_id"], name: "index_project_source_configurations_on_project_id"
      t.index ["uuid"], name: "index_project_source_configurations_on_uuid", unique: true
    end
  
    create_table "project_sources", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.integer "framework"
      t.integer "layer"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.jsonb "files"
      t.jsonb "metadata", default: {}
      t.integer "platform", default: 0
      t.boolean "is_import", default: false
      t.index ["project_id"], name: "index_project_sources_on_project_id"
    end
  
    create_table "project_token_usages", force: :cascade do |t|
      t.bigint "project_id"
      t.string "usagable_type"
      t.bigint "usagable_id"
      t.integer "output_tokens", default: 0
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "input_tokens", default: 0
      t.string "model", default: "gpt-4", null: false
      t.string "provider", default: "openai", null: false
      t.jsonb "metadata", default: {}
      t.bigint "organisation_id"
      t.integer "status", default: 0
      t.bigint "user_id"
      t.index ["project_id"], name: "index_project_token_usages_on_project_id"
      t.index ["usagable_type", "usagable_id"], name: "index_project_token_usages_on_usagable"
      t.index ["user_id"], name: "index_project_token_usages_on_user_id"
    end
  
    create_table "project_users", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.bigint "user_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id", "user_id"], name: "index_project_users_on_project_id_and_user_id", unique: true
      t.index ["project_id"], name: "index_project_users_on_project_id"
      t.index ["user_id"], name: "index_project_users_on_user_id"
    end
  
    create_table "project_variables", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.integer "platform", default: 1
      t.integer "language", default: 0
      t.string "name", null: false
      t.string "value", null: false
      t.string "group", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_project_variables_on_project_id"
    end
  
    create_table "projects", force: :cascade do |t|
      t.string "name", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "table_definitions_count", default: 0, null: false
      t.string "repo_url"
      t.string "meta_title"
      t.text "meta_description"
      t.string "root_url"
      t.bigint "user_id", null: false
      t.integer "version", default: 0, null: false
      t.string "repo_name"
      t.text "repo_description"
      t.integer "external_export_status"
      t.boolean "freeze_status", default: false
      t.string "react_repo_name"
      t.string "react_repo_description"
      t.datetime "exported_at", precision: nil, default: "2024-12-23 01:42:54"
      t.text "translation_file_raw"
      t.json "translation_file"
      t.string "bundle_id"
      t.text "backend_translation_file_raw"
      t.json "backend_translation_file"
      t.integer "parent_id"
      t.string "migration_id"
      t.text "description"
      t.string "slug"
      t.string "time_zone", default: "UTC", null: false
      t.string "domain_name", default: "*", null: false
      t.datetime "deleted_at"
      t.datetime "version_migrated_at"
      t.integer "imported_web_page_count", default: 0
      t.integer "imported_mobile_page_count", default: 0
      t.boolean "early_access_team_collaboration", default: false
      t.bigint "organisation_id"
      t.integer "managed_by", default: 0
      t.string "import_by"
      t.uuid "uuid", default: -> { "gen_random_uuid()" }
      t.string "created_from", default: "web"
      t.index ["migration_id"], name: "index_projects_on_migration_id"
      t.index ["name", "user_id"], name: "index_projects_on_name_and_user_id", unique: true
      t.index ["parent_id"], name: "index_projects_on_parent_id"
      t.index ["slug"], name: "index_projects_on_slug", unique: true
      t.index ["user_id"], name: "index_projects_on_user_id"
      t.index ["uuid"], name: "index_projects_on_uuid", unique: true
    end
  
    create_table "projects_invitations", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.datetime "accepted_at"
      t.datetime "expired_at", null: false
      t.string "token", null: false
      t.string "email", null: false
      t.string "status", default: "pending", null: false
      t.string "role", default: "viewer", null: false
      t.integer "sender_id"
      t.bigint "user_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id", "email"], name: "index_projects_invitations_on_project_id_and_email"
      t.index ["project_id"], name: "index_projects_invitations_on_project_id"
      t.index ["token"], name: "index_projects_invitations_on_token", unique: true
      t.index ["user_id"], name: "index_projects_invitations_on_user_id"
    end
  
    create_table "projects_qa_settings", force: :cascade do |t|
      t.integer "project_id", null: false
      t.string "http_basic_username"
      t.string "http_basic_password"
      t.string "url", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "login_path"
      t.string "label"
      t.integer "token_expiration_duration"
      t.json "header"
      t.index ["project_id"], name: "index_projects_qa_settings_on_project_id"
      t.index ["url", "project_id"], name: "index_projects_qa_settings_on_url_and_project_id", unique: true
    end
  
    create_table "projects_users_settings", force: :cascade do |t|
      t.bigint "user_id", null: false
      t.bigint "project_id", null: false
      t.jsonb "settings", default: {}
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_projects_users_settings_on_project_id"
      t.index ["user_id", "project_id"], name: "index_projects_users_settings_on_user_id_and_project_id", unique: true
      t.index ["user_id"], name: "index_projects_users_settings_on_user_id"
    end
  
    create_table "qa_settings_configs", force: :cascade do |t|
      t.string "label"
      t.string "username", null: false
      t.string "password", null: false
      t.string "login_path"
      t.integer "token_expiration_duration"
      t.string "code"
      t.json "storage_state"
      t.bigint "projects_qa_setting_id", null: false
      t.datetime "storage_state_saved_at"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["projects_qa_setting_id"], name: "index_qa_settings_configs_on_projects_qa_setting_id"
      t.index ["username", "projects_qa_setting_id"], name: "unique_username_config", unique: true
    end
  
    create_table "quads", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
      t.bigint "project_id", null: false
      t.string "graph", null: false
      t.string "subject", null: false
      t.string "predicate", null: false
      t.string "object", null: false
      t.jsonb "metadata", default: {}, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_quads_on_project_id"
    end
  
    create_table "query_conditions", force: :cascade do |t|
      t.bigint "column_definition_id"
      t.integer "joining_condition"
      t.integer "order"
      t.integer "query", null: false
      t.string "default_value"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "mapping_variable_type"
      t.bigint "mapping_variable_id"
      t.bigint "model_function_id"
      t.index ["column_definition_id"], name: "index_query_conditions_on_column_definition_id"
      t.index ["mapping_variable_type", "mapping_variable_id"], name: "index_query_conditions_on_mapping_variable"
      t.index ["model_function_id"], name: "index_query_conditions_on_model_function_id"
    end
  
    create_table "references", force: :cascade do |t|
      t.bigint "message_id", null: false
      t.string "name"
      t.string "origin"
      t.string "reference_type"
      t.string "category"
      t.text "content"
      t.jsonb "metadata", default: {}
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["message_id"], name: "index_references_on_message_id"
    end
  
    create_table "refresh_auth_tokens", force: :cascade do |t|
      t.bigint "identical_id", null: false
      t.string "identical_type"
      t.string "encrypted_token", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["encrypted_token"], name: "index_refresh_auth_tokens_on_encrypted_token"
    end
  
    create_table "relations", force: :cascade do |t|
      t.bigint "table_definition_id", null: false
      t.integer "relation_type", null: false
      t.boolean "required", default: false, null: false
      t.integer "related_table_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "through_table_id"
      t.string "foreign_key"
      t.datetime "deleted_at", precision: nil
      t.bigint "migration_id"
      t.boolean "default", default: false
      t.string "polymorphic_type"
      t.string "uuid"
      t.boolean "counter_cache", default: false
      t.index ["foreign_key", "table_definition_id", "related_table_id"], name: "index_relations_on_foreign_key_unique", unique: true
      t.index ["migration_id"], name: "index_relations_on_migration_id"
      t.index ["table_definition_id"], name: "index_relations_on_table_definition_id"
    end
  
    create_table "repositories", force: :cascade do |t|
      t.string "name"
      t.string "description"
      t.bigint "project_id", null: false
      t.text "info"
      t.integer "provider"
      t.integer "status"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "category"
      t.index ["project_id"], name: "index_repositories_on_project_id"
    end
  
    create_table "request_params", force: :cascade do |t|
      t.integer "category", null: false
      t.string "name", null: false
      t.integer "of_type"
      t.integer "data_type"
      t.boolean "allow_null", default: false
      t.bigint "parent_id"
      t.string "internal_connection_type"
      t.bigint "internal_connection_id"
      t.bigint "api_function_id"
      t.string "default_value"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "system_setting_id"
      t.string "description"
      t.boolean "required"
      t.index ["api_function_id"], name: "index_request_params_on_api_function_id"
      t.index ["internal_connection_type", "internal_connection_id"], name: "index_request_params_on_internal_connection"
      t.index ["parent_id"], name: "index_request_params_on_parent_id"
      t.index ["system_setting_id"], name: "index_request_params_on_system_setting_id"
    end
  
    create_table "resources", force: :cascade do |t|
      t.bigint "chat_id", null: false
      t.bigint "message_id"
      t.string "name"
      t.text "content"
      t.string "resource_type"
      t.string "status", default: "draft"
      t.string "category"
      t.jsonb "metadata", default: {}
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.index ["chat_id"], name: "index_resources_on_chat_id"
      t.index ["message_id"], name: "index_resources_on_message_id"
      t.index ["uuid"], name: "index_resources_on_uuid", unique: true
    end
  
    create_table "responses", force: :cascade do |t|
      t.string "name", null: false
      t.integer "of_type"
      t.integer "data_type", null: false
      t.bigint "parent_id"
      t.string "dynamic_reference_type"
      t.bigint "dynamic_reference_id"
      t.string "calling_function_type"
      t.bigint "calling_function_id"
      t.string "visibility_condition", default: "public"
      t.string "default_value"
      t.integer "category"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "output_id"
      t.integer "relation_table_reference_id"
      t.index ["calling_function_type", "calling_function_id"], name: "index_responses_on_calling_function"
      t.index ["dynamic_reference_type", "dynamic_reference_id"], name: "index_responses_on_dynamic_reference"
      t.index ["output_id"], name: "index_responses_on_output_id"
      t.index ["parent_id"], name: "index_responses_on_parent_id"
    end
  
    create_table "screens", force: :cascade do |t|
      t.text "name"
      t.text "data"
      t.bigint "project_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_screens_on_project_id"
    end
  
    create_table "search_display_params", force: :cascade do |t|
      t.bigint "dashboard_id", null: false
      t.bigint "column_definition_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["column_definition_id"], name: "index_search_display_params_on_column_definition_id"
      t.index ["dashboard_id", "column_definition_id"], name: "search_unique_dashboard_column", unique: true
      t.index ["dashboard_id"], name: "index_search_display_params_on_dashboard_id"
    end
  
    create_table "seed_data_headers", force: :cascade do |t|
      t.bigint "seed_data_sheet_id", null: false
      t.bigint "column_definition_id"
      t.string "title"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["column_definition_id"], name: "index_seed_data_headers_on_column_definition_id"
      t.index ["seed_data_sheet_id"], name: "index_seed_data_headers_on_seed_data_sheet_id"
    end
  
    create_table "seed_data_records", force: :cascade do |t|
      t.bigint "seed_data_sheet_id", null: false
      t.json "data_record"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "order_index"
      t.index ["seed_data_sheet_id"], name: "index_seed_data_records_on_seed_data_sheet_id"
    end
  
    create_table "seed_data_sheets", force: :cascade do |t|
      t.string "name", null: false
      t.bigint "project_id", null: false
      t.bigint "table_definition_id"
      t.integer "status", default: 0
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "order_index"
      t.index ["project_id"], name: "index_seed_data_sheets_on_project_id"
      t.index ["table_definition_id"], name: "index_seed_data_sheets_on_table_definition_id"
    end
  
    create_table "static_pages", force: :cascade do |t|
      t.string "slug", null: false
      t.string "title", null: false
      t.text "content", null: false
      t.bigint "project_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_static_pages_on_project_id"
    end
  
    create_table "studio_imports", force: :cascade do |t|
      t.string "job_id", default: "", null: false
      t.integer "status", default: 0
      t.integer "import_type"
      t.integer "progress", default: 0
      t.text "progress_message"
      t.text "error_message"
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_studio_imports_on_project_id"
    end
  
    create_table "subscription_prices", force: :cascade do |t|
      t.string "price_id", null: false
      t.boolean "active", default: false
      t.boolean "system_active", default: false
      t.string "currency"
      t.integer "price_type"
      t.integer "unit_amount"
      t.string "billing_scheme"
      t.integer "recurring_interval"
      t.integer "recurring_interval_count"
      t.integer "recurring_trial_period_days"
      t.integer "recurring_usage_type"
      t.bigint "subscription_product_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["subscription_product_id"], name: "index_subscription_prices_on_subscription_product_id"
    end
  
    create_table "subscription_products", force: :cascade do |t|
      t.string "product_id", null: false
      t.string "name", null: false
      t.string "description"
      t.boolean "active", default: false
      t.boolean "system_active", default: false
      t.boolean "livemode", default: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "subscriptions", force: :cascade do |t|
      t.string "subscription_id"
      t.integer "invoice_id"
      t.integer "status", default: 0
      t.boolean "cancel_at_period_end", default: false
      t.datetime "current_period_start"
      t.datetime "current_period_end"
      t.bigint "subscription_price_id"
      t.string "payer_type"
      t.bigint "payer_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "receipt_number"
      t.json "payment_method"
      t.integer "quantity", default: 1
      t.integer "subscription_type", default: 0
      t.string "schedule_id"
      t.text "cancel_reason"
      t.datetime "cancelled_at"
      t.integer "seat_count", default: 0, null: false
      t.index ["payer_type", "payer_id"], name: "index_subscriptions_on_payer"
      t.index ["receipt_number"], name: "index_subscriptions_on_receipt_number", unique: true
      t.index ["subscription_price_id"], name: "index_subscriptions_on_subscription_price_id"
    end
  
    create_table "system_settings", force: :cascade do |t|
      t.string "name", null: false
      t.integer "tag", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["name"], name: "index_system_settings_on_name", unique: true
    end
  
    create_table "table_definition_indices", force: :cascade do |t|
      t.string "name"
      t.bigint "table_definition_id", null: false
      t.boolean "unique", default: false, null: false
      t.integer "column_definition_indices_count", default: 0, null: false
      t.string "uuid"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["table_definition_id"], name: "index_table_definition_indices_on_table_definition_id"
    end
  
    create_table "table_definitions", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.string "name", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "column_definitions_count", default: 0, null: false
      t.integer "relations_count", default: 0, null: false
      t.integer "order", default: 0, null: false
      t.string "comment", default: ""
      t.string "namespace", default: ""
      t.datetime "deleted_at", precision: nil
      t.bigint "migration_id"
      t.boolean "default", default: false
      t.float "latitude", default: 0.0, null: false
      t.float "longitude", default: 0.0, null: false
      t.string "uuid"
      t.integer "managed_by", default: 0
      t.boolean "locked", default: false, null: false
      t.integer "source", default: 0
      t.index ["migration_id"], name: "index_table_definitions_on_migration_id"
      t.index ["name", "project_id", "deleted_at"], name: "index_table_definitions_on_name_and_project_id_and_deleted_at", unique: true
      t.index ["project_id"], name: "index_table_definitions_on_project_id"
    end
  
    create_table "team_members", force: :cascade do |t|
      t.bigint "organisation_id", null: false
      t.bigint "project_id", null: false
      t.bigint "member_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["member_id"], name: "index_team_members_on_member_id"
      t.index ["organisation_id", "project_id", "member_id"], name: "index_team_members_on_org_project_member", unique: true
      t.index ["organisation_id"], name: "index_team_members_on_organisation_id"
      t.index ["project_id"], name: "index_team_members_on_project_id"
    end
  
    create_table "template_categories", force: :cascade do |t|
      t.bigint "template_id"
      t.bigint "category_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["category_id"], name: "index_template_categories_on_category_id"
      t.index ["template_id"], name: "index_template_categories_on_template_id"
    end
  
    create_table "templates", force: :cascade do |t|
      t.string "name", null: false
      t.integer "template_type"
      t.integer "project_type"
      t.integer "order"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "template_page_id"
      t.index ["name", "template_type", "project_type"], name: "index_templates_on_name_and_template_type_and_project_type", unique: true
      t.index ["name"], name: "index_templates_on_name"
    end
  
    create_table "test_case_step_results", force: :cascade do |t|
      t.integer "test_case_step_id"
      t.string "message"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "test_cases_test_case_result_id"
      t.bigint "version_id"
      t.index ["test_case_step_id"], name: "index_test_case_step_results_on_test_case_step_id"
      t.index ["test_cases_test_case_result_id"], name: "index_test_case_step_results_on_test_cases_test_case_result_id"
      t.index ["version_id"], name: "index_test_case_step_results_on_version_id"
    end
  
    create_table "test_case_steps", force: :cascade do |t|
      t.integer "test_case_id"
      t.string "step", null: false
      t.integer "order", default: 1
      t.string "status", default: "not_started"
      t.integer "test_case_step_result_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.text "code"
      t.uuid "node_id", default: -> { "gen_random_uuid()" }, null: false
      t.index ["test_case_id"], name: "index_test_case_steps_on_test_case_id"
      t.index ["test_case_step_result_id"], name: "index_test_case_steps_on_test_case_step_result_id"
    end
  
    create_table "test_cases", force: :cascade do |t|
      t.integer "test_suite_id"
      t.string "name", null: false
      t.integer "order", default: 1
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.text "code"
      t.uuid "node_id", default: -> { "gen_random_uuid()" }, null: false
      t.boolean "authentication_required_flag"
      t.index ["test_suite_id"], name: "index_test_cases_on_test_suite_id"
    end
  
    create_table "test_cases_import_page_test_values", force: :cascade do |t|
      t.bigint "project_import_page_id"
      t.bigint "qa_settings_config_id"
      t.bigint "qa_setting_id"
      t.boolean "authentication_required", default: false
      t.string "test_suite_node_id"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_import_page_id"], name: "index_import_page_test_users_on_project_import_pages_id"
      t.index ["qa_setting_id"], name: "index_test_cases_import_page_test_values_on_qa_setting_id"
      t.index ["qa_settings_config_id"], name: "index_import_page_test_users_on_qa_settings_configs_id"
      t.index ["test_suite_node_id"], name: "test_suite_node_id_index"
    end
  
    create_table "test_cases_test_case_results", force: :cascade do |t|
      t.integer "completion_time"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.bigint "project_generate_id"
      t.bigint "test_case_id"
      t.index ["project_generate_id"], name: "index_test_cases_test_case_results_on_project_generate_id"
      t.index ["test_case_id"], name: "index_test_cases_test_case_results_on_test_case_id"
    end
  
    create_table "translations", force: :cascade do |t|
      t.string "language"
      t.string "locale_group"
      t.string "key_name"
      t.string "value"
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_translations_on_project_id"
    end
  
    create_table "tutorial_item_users", force: :cascade do |t|
      t.bigint "tutorial_item_id", null: false
      t.bigint "user_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["tutorial_item_id"], name: "index_tutorial_item_users_on_tutorial_item_id"
      t.index ["user_id"], name: "index_tutorial_item_users_on_user_id"
    end
  
    create_table "tutorial_items", force: :cascade do |t|
      t.string "title", null: false
      t.text "description", null: false
      t.integer "order_index"
      t.string "document_url"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
    end
  
    create_table "ui_ux_documents", force: :cascade do |t|
      t.bigint "project_id", null: false
      t.string "status"
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_ui_ux_documents_on_project_id"
    end
  
    create_table "user_settings", force: :cascade do |t|
      t.string "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.bigint "user_id", null: false
      t.jsonb "ide_settings", default: {}, null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.string "language_code", default: "en", null: false
      t.index ["user_id"], name: "index_user_settings_on_user_id", unique: true
    end
  
    create_table "users", force: :cascade do |t|
      t.string "email", default: "", null: false
      t.string "encrypted_password", default: "", null: false
      t.string "reset_password_token"
      t.datetime "reset_password_sent_at", precision: nil
      t.datetime "remember_created_at", precision: nil
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.datetime "deleted_at"
      t.integer "role", default: 2
      t.string "first_name"
      t.string "last_name"
      t.integer "position"
      t.integer "failed_attempts", default: 0, null: false
      t.datetime "locked_at"
      t.string "unlock_token"
      t.string "current_locale", default: "en"
      t.string "confirmation_token"
      t.datetime "confirmed_at"
      t.datetime "confirmation_sent_at"
      t.string "unconfirmed_email"
      t.integer "user_type", default: 0
      t.datetime "password_changed_at"
      t.string "created_from", default: "web"
      t.uuid "uuid", default: -> { "gen_random_uuid()" }, null: false
      t.string "otp_secret"
      t.integer "consumed_timestep"
      t.boolean "otp_required_for_login", default: false
      t.datetime "otp_send_at"
      t.integer "authentication_strategy", default: 0
      t.string "hubspot_contact_email"
      t.boolean "active", default: true
      t.jsonb "metadata", default: {}
      t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
      t.index ["deleted_at"], name: "index_users_on_deleted_at"
      t.index ["email"], name: "index_users_on_email", unique: true
      t.index ["metadata"], name: "index_users_on_metadata", using: :gin
      t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
      t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
      t.index ["uuid"], name: "index_users_on_uuid", unique: true
    end
  
    create_table "vault_details", force: :cascade do |t|
      t.integer "env", null: false
      t.string "secret_path", null: false
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.boolean "shared", default: true
      t.string "credentials_path", null: false
      t.bigint "deployment_id"
      t.string "aws_account_id", default: "", null: false
      t.string "zone_id", default: ""
      t.string "domain"
      t.string "slack_channel_id", default: "", null: false, comment: "Default Slack Channel ID(jitera-github channle) added we can change it based on use cases\n"
      t.string "slack_workspace_id", default: "", null: false, comment: "This will be workspace id after authorization of slack in AWS default added for Jitera exported project and Jitera slack channel can change based on use cases\n"
      t.string "database_host_title"
      t.string "database_name"
      t.string "database_password"
      t.string "database_password_title"
      t.string "database_user"
      t.string "github_account"
      t.string "github_branch"
      t.string "github_repository"
      t.string "github_token"
      t.string "name"
      t.string "notify_channel_name"
      t.string "project_name"
      t.string "project_name_dash"
      t.string "project_name_underscore"
      t.string "rails_master_key"
      t.string "rds_name"
      t.string "redis_name"
      t.string "security_group_name"
      t.string "terraform_bucket"
      t.string "vpc_name"
      t.string "web_container_name"
      t.string "aws_region"
      t.string "aws_secret_key"
      t.string "aws_access_key"
      t.index ["aws_account_id", "env", "project_id"], name: "index_vault_details_on_aws_account_id_and_env_and_project_id", unique: true
      t.index ["deployment_id"], name: "index_vault_details_on_deployment_id"
      t.index ["env", "project_id"], name: "index_vault_details_on_env_and_project_id", unique: true
      t.index ["project_id"], name: "index_vault_details_on_project_id"
    end
  
    create_table "versions", force: :cascade do |t|
      t.string "item_type"
      t.string "{:null=>false, :limit=>191}"
      t.bigint "item_id", null: false
      t.string "event", null: false
      t.string "whodunnit"
      t.text "object"
      t.text "object_changes"
      t.datetime "created_at", precision: nil
      t.bigint "project_id"
      t.index ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"
      t.index ["project_id"], name: "index_versions_on_project_id"
    end
  
    create_table "web_emails", force: :cascade do |t|
      t.string "name", null: false
      t.string "subject", null: false
      t.text "content", null: false
      t.bigint "web_mailer_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["web_mailer_id"], name: "index_web_emails_on_web_mailer_id"
    end
  
    create_table "web_front_display_params", force: :cascade do |t|
      t.bigint "web_front_id", null: false
      t.bigint "column_definition_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["column_definition_id"], name: "index_web_front_display_params_on_column_definition_id"
      t.index ["web_front_id"], name: "index_web_front_display_params_on_web_front_id"
    end
  
    create_table "web_fronts", force: :cascade do |t|
      t.bigint "table_definition_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.integer "web_front_type"
      t.boolean "auth"
      t.boolean "use_authed_record"
      t.index ["table_definition_id"], name: "index_web_fronts_on_table_definition_id"
    end
  
    create_table "web_mailers", force: :cascade do |t|
      t.string "name", null: false
      t.bigint "project_id", null: false
      t.datetime "created_at", null: false
      t.datetime "updated_at", null: false
      t.index ["project_id"], name: "index_web_mailers_on_project_id"
    end
  
    add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
    add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
    add_foreign_key "agents", "llms"
    add_foreign_key "agents", "projects"
    add_foreign_key "api_functions", "projects"
    add_foreign_key "app_page_localizations", "localizations"
    add_foreign_key "blocks_locks", "blocks"
    add_foreign_key "blocks_locks", "users"
    add_foreign_key "blocks_table_definitions", "blocks"
    add_foreign_key "blocks_table_definitions", "table_definitions"
    add_foreign_key "blocks_translations", "blocks"
    add_foreign_key "business_logic_groups", "blocks"
    add_foreign_key "business_logic_groups", "groups"
    add_foreign_key "chats", "projects"
    add_foreign_key "chats", "users"
    add_foreign_key "code_pushes", "repositories"
    add_foreign_key "collaborators", "organisations"
    add_foreign_key "column_definition_indices", "column_definitions"
    add_foreign_key "column_definition_indices", "table_definition_indices"
    add_foreign_key "comments", "projects"
    add_foreign_key "comments", "users"
    add_foreign_key "company_members", "companies"
    add_foreign_key "company_members", "users"
    add_foreign_key "component_descriptions", "component_specifications"
    add_foreign_key "component_specification_apis", "blocks"
    add_foreign_key "component_specification_apis", "component_specifications"
    add_foreign_key "component_specifications", "component_specifications", column: "parent_id"
    add_foreign_key "configurations", "features"
    add_foreign_key "dashboard_display_params", "column_definitions"
    add_foreign_key "dashboard_display_params", "dashboards"
    add_foreign_key "dashboards", "table_definitions"
    add_foreign_key "deployments", "projects"
    add_foreign_key "development_plans", "development_plans", column: "parent_id"
    add_foreign_key "editor_localizations", "projects"
    add_foreign_key "enum_values", "column_definitions"
    add_foreign_key "feature_actions", "features"
    add_foreign_key "feature_operations", "operations"
    add_foreign_key "feature_tables", "features"
    add_foreign_key "feature_tables", "operations"
    add_foreign_key "feature_whitelists", "feature_toggles"
    add_foreign_key "form_inputs", "column_definitions"
    add_foreign_key "form_inputs", "mobile_app_pages"
    add_foreign_key "function_arguments", "arguments"
    add_foreign_key "git_commit_shas", "project_imports"
    add_foreign_key "git_commit_shas", "projects"
    add_foreign_key "git_pull_requests", "projects"
    add_foreign_key "hosted_zones", "organizations"
    add_foreign_key "invitations", "projects"
    add_foreign_key "invitations", "users"
    add_foreign_key "ips", "projects"
    add_foreign_key "jira_projects", "jira_tokens"
    add_foreign_key "jira_projects", "projects"
    add_foreign_key "jira_tickets", "blocks"
    add_foreign_key "jira_tickets", "jira_projects"
    add_foreign_key "jira_tickets", "projects"
    add_foreign_key "jira_tokens", "projects"
    add_foreign_key "jira_tokens", "users"
    add_foreign_key "localizations", "languages"
    add_foreign_key "localizations", "projects"
    add_foreign_key "mapping_locations", "component_specifications"
    add_foreign_key "members", "organisations"
    add_foreign_key "members", "users"
    add_foreign_key "messages", "chats"
    add_foreign_key "messages", "users"
    add_foreign_key "migrations", "projects"
    add_foreign_key "mobile_app_page_links", "mobile_app_pages"
    add_foreign_key "mobile_app_page_links", "mobile_app_pages", column: "to_page_id"
    add_foreign_key "mobile_app_pages", "table_definitions"
    add_foreign_key "model_functions", "projects"
    add_foreign_key "module_requests", "projects"
    add_foreign_key "module_requests", "users"
    add_foreign_key "oauth_access_grants", "oauth_applications", column: "application_id"
    add_foreign_key "oauth_access_tokens", "oauth_applications", column: "application_id"
    add_foreign_key "operations", "features"
    add_foreign_key "organisation_invitations", "organisations"
    add_foreign_key "organisations", "companies"
    add_foreign_key "organizations", "projects"
    add_foreign_key "organizations", "users"
    add_foreign_key "payment_methods", "organisations"
    add_foreign_key "payments", "organisations"
    add_foreign_key "payments", "users"
    add_foreign_key "project_assets", "projects"
    add_foreign_key "project_block_changes", "projects"
    add_foreign_key "project_connect_notions", "project_notion_providers"
    add_foreign_key "project_document_changes", "projects"
    add_foreign_key "project_exports", "project_generates"
    add_foreign_key "project_exports", "project_generates", column: "project_generate_queue_id"
    add_foreign_key "project_exports", "project_sources"
    add_foreign_key "project_exports", "projects"
    add_foreign_key "project_feature_api_functions", "api_functions"
    add_foreign_key "project_feature_api_functions", "project_features"
    add_foreign_key "project_feature_tables", "feature_tables"
    add_foreign_key "project_feature_tables", "table_definitions"
    add_foreign_key "project_feedbacks", "projects"
    add_foreign_key "project_feedbacks", "users"
    add_foreign_key "project_figma_files", "project_figma_imports"
    add_foreign_key "project_figma_files", "projects"
    add_foreign_key "project_figma_imports", "projects"
    add_foreign_key "project_figma_providers", "projects"
    add_foreign_key "project_figma_providers", "users"
    add_foreign_key "project_generate_actions", "project_generates"
    add_foreign_key "project_generates", "project_generates", column: "parent_id"
    add_foreign_key "project_generates", "project_sources"
    add_foreign_key "project_generates", "projects"
    add_foreign_key "project_git_changes", "projects"
    add_foreign_key "project_git_hosts", "projects"
    add_foreign_key "project_git_hosts", "users"
    add_foreign_key "project_git_providers", "project_git_hosts"
    add_foreign_key "project_git_providers", "projects"
    add_foreign_key "project_git_providers", "users"
    add_foreign_key "project_git_repositories", "project_git_providers"
    add_foreign_key "project_html_screens", "blocks"
    add_foreign_key "project_import_page_components", "project_import_pages", on_delete: :cascade
    add_foreign_key "project_import_pages", "project_sources"
    add_foreign_key "project_import_pages", "projects"
    add_foreign_key "project_import_translation_contents", "project_import_translation_keys"
    add_foreign_key "project_import_translation_files", "projects"
    add_foreign_key "project_import_translation_keys", "project_sources"
    add_foreign_key "project_import_translation_keys", "projects"
    add_foreign_key "project_imports", "project_sources"
    add_foreign_key "project_imports", "projects"
    add_foreign_key "project_migrations", "projects"
    add_foreign_key "project_notion_imports", "projects"
    add_foreign_key "project_notion_imports", "users"
    add_foreign_key "project_notion_pages", "project_notion_providers"
    add_foreign_key "project_notion_pages", "projects"
    add_foreign_key "project_notion_pages", "users"
    add_foreign_key "project_notion_providers", "projects"
    add_foreign_key "project_notion_providers", "users"
    add_foreign_key "project_overviews", "projects"
    add_foreign_key "project_pdf_imports", "projects"
    add_foreign_key "project_previews", "projects"
    add_foreign_key "project_screens", "blocks"
    add_foreign_key "project_screens", "documents"
    add_foreign_key "project_screens", "projects"
    add_foreign_key "project_share_links", "projects"
    add_foreign_key "project_shares", "projects"
    add_foreign_key "project_shares", "users"
    add_foreign_key "project_source_configurations", "projects"
    add_foreign_key "project_sources", "projects"
    add_foreign_key "project_token_usages", "projects"
    add_foreign_key "project_token_usages", "users"
    add_foreign_key "project_users", "projects"
    add_foreign_key "project_users", "users"
    add_foreign_key "project_variables", "projects"
    add_foreign_key "projects", "users"
    add_foreign_key "projects_invitations", "projects"
    add_foreign_key "projects_users_settings", "projects"
    add_foreign_key "projects_users_settings", "users"
    add_foreign_key "quads", "projects"
    add_foreign_key "references", "messages"
    add_foreign_key "repositories", "projects"
    add_foreign_key "resources", "chats"
    add_foreign_key "resources", "messages"
    add_foreign_key "search_display_params", "column_definitions"
    add_foreign_key "search_display_params", "dashboards"
    add_foreign_key "seed_data_headers", "column_definitions"
    add_foreign_key "seed_data_headers", "seed_data_sheets"
    add_foreign_key "seed_data_records", "seed_data_sheets"
    add_foreign_key "seed_data_sheets", "projects"
    add_foreign_key "seed_data_sheets", "table_definitions"
    add_foreign_key "studio_imports", "projects"
    add_foreign_key "subscription_prices", "subscription_products"
    add_foreign_key "subscriptions", "subscription_prices"
    add_foreign_key "table_definition_indices", "table_definitions"
    add_foreign_key "team_members", "members"
    add_foreign_key "team_members", "organisations"
    add_foreign_key "team_members", "projects"
    add_foreign_key "tutorial_item_users", "tutorial_items"
    add_foreign_key "tutorial_item_users", "users"
    add_foreign_key "ui_ux_documents", "projects"
    add_foreign_key "user_settings", "users"
    add_foreign_key "vault_details", "projects"
    add_foreign_key "web_emails", "web_mailers"
    add_foreign_key "web_front_display_params", "column_definitions"
    add_foreign_key "web_front_display_params", "web_fronts"
    add_foreign_key "web_fronts", "table_definitions"
    add_foreign_key "web_mailers", "projects"
  end
  