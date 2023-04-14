connection: "sample_bigquery_connection"

include: "/**/order_items*"
include: "/**/orders*"
include: "/**/inventory_items*"
include: "/**/products*"
include: "/**/users*"
include: "/**/distribution_centers*"
# explore: order_items {}
# explore: distribution_centers {
#   # join: order_items {
#   #   sql_on: ${distribution_centers.id}=${order_items.product_id} ;;
#   #   relationship: many_to_many
#   # }
# sql_always_where:
# 1=1
# --place for liquid testing here
# --my name: {{_user_attributes['name']}}
# --id is selected: {{id._is_selected}}
# ;;
# # --can i see a set {{distribution_centers.all_dimensions._is_selected}} #can't reference a set like this
# }

#Special Handling for this explore
view: order_items_for_order_items_explore{
  extends: [order_items]
  #duplicative with a field in orders
  dimension: status {view_label:"ZZ to be hidden" group_label: "duplicative in this explore"}
  dimension_group: delivered {hidden: yes}
  dimension_group: returned {hidden: yes}
  dimension_group: shipped {hidden: yes}

  #hidden because it's the primary date
  dimension_group: created {hidden: yes view_label:"Other Dates" label:"{{_view._name}}-{{_field._name | replace: _view._name,'' | replace:'.',''|  split:'_' | first}}"}
}
view: orders_for_order_items_explore {
  extends: [orders]
  #duplicative with a field in users
  dimension: gender {view_label:"ZZ to be hidden" group_label: "duplicative in this explore"}

  #move non-primary dates to a dedicated folder
  dimension_group: delivered {hidden: no view_label:"Other Dates" label:"{{_view._name}}-{{_field._name | replace: _view._name,'' | replace:'.',''|  split:'_' | first}}"}
  dimension_group: returned {hidden: no view_label:"Other Dates" label:"{{_view._name}}-{{_field._name | replace: _view._name,'' | replace:'.',''|  split:'_' | first}}"}
  dimension_group: shipped {hidden: no view_label:"Other Dates" label:"{{_view._name}}-{{_field._name | replace: _view._name,'' | replace:'.',''|  split:'_' | first}}"}
  #hidden because it's the primary date
  dimension_group: created {hidden: yes view_label:"Other Dates" label:"{{_view._name}}-{{_field._name | replace: _view._name,'' | replace:'.',''|  split:'_' | first}}"}
}
view: inventory_items_for_order_items_explore {
  extends: [inventory_items]
  #duplicative with a fields in product
  fields_hidden_by_default: yes

  #move non-primary dates to a dedicated folder
  dimension_group: created {hidden: no view_label:"Other Dates" label:"{{_view._name}}-{{_field._name | replace: _view._name,'' | replace:'.',''|  split:'_' | first}}"}
  dimension_group: sold {hidden: no view_label:"Other Dates" label:"{{_view._name}}-{{_field._name | replace: _view._name,'' | replace:'.',''|  split:'_' | first}}"}
}
view: products_for_order_items_explore {
  extends: [products]
  #in this context, product info is detail about the order item
  # view_label: "Order Items"
  dimension: VIEW_LABEL {sql:Order Items;;}
}
view: users_for_order_items_explore {
  extends: [users]
  #move non-primary dates to a dedicated folder
  dimension_group: created {hidden: no view_label:"Other Dates" label:"{{_view._name}}-{{_field._name | replace: _view._name,'' | replace:'.',''|  split:'_' | first}}"}
}

include: "/**/*main_date_for_explore*"
view: main_date_for_order_items_explore {
  extends: [main_date_for_explore]
  dimension_group: date {
    label: "Order"
    sql: ${order_items.created_raw} ;;
  }
}
explore: order_items {
  from: order_items_for_order_items_explore
  view_name: order_items
  join: orders {
    from: orders_for_order_items_explore
    relationship: many_to_one
    sql_on: ${order_items.order_id}=${orders.primary_key_field} ;;
  }
  join: users {
    from: users_for_order_items_explore
    relationship: many_to_one
    sql_on: ${order_items.user_id}=${users.primary_key_field} ;;
  }
  join: products {
    from: products_for_order_items_explore
    relationship: many_to_one
    sql_on: ${order_items.product_id}=${products.primary_key_field} ;;
  }
  join: inventory_items {
    from: inventory_items_for_order_items_explore
    relationship: many_to_one
    sql_on: ${order_items.inventory_item_id}=${inventory_items.primary_key_field} ;;
  }
  join: distribution_centers {
    relationship: many_to_one
    sql_on: ${order_items.inventory_item_id}=${distribution_centers.primary_key_field} ;;
  }

  join: main_date_for_order_items_explore {relationship:one_to_one sql: ;;}

}
