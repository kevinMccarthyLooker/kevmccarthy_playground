#MODEL - PARAMS
# label: possibly-localized-string
connection: "sample_bigquery_connection"
# fiscal_month_offset: number
# week_start_day: monday or ...
# case_sensitive: yes or no
# persist_for: "string"
# persist_with: datagroup-ref

# MODEL - PARAMS/OBJECTS WHERE 1 OR MORE CAN BE ADDED
# include: "string"
# explore: identifier
# view: identifier
# test: identifier
# access_grant: identifier
# datagroup: identifier
# map_layer: identifier
# named_value_format: identifier


include: "/**/*looker_release_notes*" #explore: looker_release_notes {}

include: "/**/*writer*" #explore: writer {}

include: "/**/*default_date_param_question*" #explore: default_date_param_question {}

include: "/**/*procedural_bq*" # explore: procedural_bq {}

include: "/**/*timeline_example_data*" # explore: timeline_example_data {}
