### UPDATE TO AUTO-GENERATED VIEW
include: "orders*"
include: "/**/*template_view*"
#Apply exceptions to templated fields, e.g. if primary key fields is not ${id}, standard updates to view label, etc.
view: +orders {
  extends: [template_view]

  dimension: primary_key_field {sql:${order_id};;}
  dimension: VIEW_LABEL {sql:Order Info;;}
}

view: +orders {
  dimension: user_id {view_label: "ZZ to be hidden"}
}
