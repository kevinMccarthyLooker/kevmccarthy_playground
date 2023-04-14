### UPDATE TO AUTO-GENERATED VIEW
# INSTRUCTIONS:
# For each new view:
#  Copy paste this in a new .lkml file of the same name as the new view
#  Then find-and-replace the views name (updates the include and the view that's being refined

include: "order_items*"
include: "/**/*template_view*"
#Apply exceptions to templated fields, e.g. if primary key fields is not ${id}, standard updates to view label, etc.
view: +order_items {
  extends: [template_view]

}

#re-label foreign Key Fields
view: +order_items {
  dimension: order_id {view_label: "ZZ to be hidden"}
  dimension: inventory_item_id {view_label: "ZZ to be hidden"}
  dimension: product_id {view_label: "ZZ to be hidden"}
  dimension: user_id {view_label: "ZZ to be hidden"}
}
