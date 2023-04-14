view: main_date_for_explore {
  extension: required
  view_label: " Date"
  dimension_group: date {
    type: time
    timeframes: [raw,date,month]
    sql: OVERRIDE ME ;;
  }
}
