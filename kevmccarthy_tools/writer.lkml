explore: writer {}

view: writer {
  derived_table: {
    sql:
    select 1;

                select 1 as id
                union all
                select 2 as id

      ;;

  }
  dimension: id {}
}
