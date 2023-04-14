explore: timeline_example_data {}

view: timeline_example_data {
  derived_table: {
    sql:
    with records as (
    select 'label1' as x_axis_label, 'detail1' as detail, '2020-01-01' as start_date, '2020-02-01' as end_date, 101 as value
    union all
    select 'label2' as x_axis_label, 'detail2' as detail, '2020-01-02' as start_date, '2020-02-02' as end_date, 201 as value
    union all
    select 'label1' as x_axis_label, 'detail2' as detail, '2020-01-03' as start_date, '2020-02-03' as end_date, 301 as value
    )
    select *, row_number() over() as row_id from records
    ;;
  }
  dimension: row_id {primary_key:yes}
  dimension: x_axis_label {}
  dimension: detail {}
  dimension: start_date {type:date}
  dimension: end_date {type:date}
  dimension: value {type:number}
  measure: count {}
  measure: total_value {type:sum sql:${value};;}
}
