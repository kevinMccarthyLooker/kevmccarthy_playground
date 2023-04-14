explore: default_date_param_question {
  sql_always_where: 1=1 /*filter value: {% date_start default_date_param_question.start_date_filter %}condition: {% condition default_date_param_question.start_date_filter %}A DATE{%endcondition%}*/;;
}

view: default_date_param_question {
  derived_table: {
    sql: select 1 as id, 101 as value union all select 2 as id, 201 as value ;;
  }
  dimension: id {}
  dimension: value {}
  measure: total_value {type: sum sql: ${value} ;;}

  dimension: test_liquid {
    sql: {{ 'now' | date: '%Y-%m-%d' |replace: '2023','2022'}} ;;
  }

  parameter: start_date_1_month {
    type: date
    # default_value: "{{ 'now' | date: '%Y-%m-%d' |replace: '2023','2022'}}  "
    default_value: "1 month ago"
  }

  filter: start_date_filter {
    type: date
    # default_value: "{{ 'now' | date: '%Y-%m-%d' |replace: '2023','2022'}}  "
    default_value: "1 month ago"
  }
  dimension: value_of_filter {
    sql: {% date_start default_date_param_question.start_date_filter %} ;;
  }
}
