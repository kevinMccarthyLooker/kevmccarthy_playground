# Standard enhancements to be applied on auto-generated views
# assumes a primary key field called id exists in the table, update as neceesary in view's refinements/extensions
view: template_view {
  extension: required

  dimension: id {view_label: "ZZ to be hidden"}

  dimension: primary_key_field {
    primary_key:yes
    view_label: "ZZ System Keys"
    label: "Primary Key of {{_view._name}}"
    sql: ${id} ;;#update as necessary
  }
  set: all_dimensions {fields:[primary_key_field]}
  measure: count {
    label: "Count ({{_view._name}})"
    type:count
    filters: [primary_key_field: "-NULL"]
  } #update standard count logic to work correctly in case of outer joins
  set: all_measures {fields:[count]}


### Take Control of View Name and View Label
# Get View Name into a dimension
  dimension: VIEW_NAME {
    view_label: "ZZ to be hidden"
    hidden: no
    sql:{{_view._name}};;
  }
# Create and use a VIEW_LABEL dimension.  Easier for subsequent use in liquid labels, etc.
  dimension: VIEW_LABEL {
    view_label: "ZZ to be hidden"
    hidden: no
    sql: {% assign input = _view._name %} @{stringify_input_string_with_underscores} ;;
  }
  view_label: "{{VIEW_LABEL._sql}}"
}
