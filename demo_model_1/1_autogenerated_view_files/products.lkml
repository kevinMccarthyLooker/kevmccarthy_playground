### UPDATE TO AUTO-GENERATED VIEW
# INSTRUCTIONS:
# For each new view:
#  Copy paste this in a new .lkml file of the same name as the new view
#  Then find-and-replace the views name (updates the include and the view that's being refined

include: "products*"
include: "/**/*template_view*"
#Apply exceptions to templated fields, e.g. if primary key fields is not ${id}, standard updates to view label, etc.
view: +products {
  extends: [template_view]

}
view: +products {
  dimension: distribution_center_id {view_label: "ZZ to be hidden"}
}
