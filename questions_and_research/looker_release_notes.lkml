explore: looker_release_notes {}

view: looker_release_notes {
  derived_table: {
    sql: SELECT *, concat(product_name,'-', published_at,'-', row_number() over(partition by product_name, published_at order by description)) as hidden_id FROM `bigquery-public-data.google_cloud_release_notes.release_notes`
          --where product_name = 'Looker'

      --union all
      --select 'placeholder' as description,
      --"placeholder" as release_note_type,
      --'2022-12-14' as published_at,
      --1 as product_id,
      --'test' as product_name,
      --null as product_version_name,
      --'1' as hidden_id
      ;;
  }

  dimension: product_name {}

  dimension: description {
    type: string
    sql: ${TABLE}.description ;;
  }

  dimension: release_note_type {
    type: string
    #All Types in the table as of 4/10/23
    case: {when:{sql:${TABLE}.release_note_type = 'BREAKING_CHANGE';; label:"BREAKING_CHANGE"}
      when:{sql:${TABLE}.release_note_type = 'DEPRECATION';; label:"DEPRECATION"}
      when:{sql:${TABLE}.release_note_type = 'SECURITY_BULLETIN';; label:"SECURITY_BULLETIN"}
      when:{sql:${TABLE}.release_note_type = 'FIX';; label:"FIX"}
      when:{sql:${TABLE}.release_note_type = 'FEATURE';; label:"FEATURE"}
      when:{sql:${TABLE}.release_note_type = 'ISSUE';; label:"ISSUE"}
      when:{sql:${TABLE}.release_note_type = 'LIBRARIES';; label:"LIBRARIES"}
      when:{sql:${TABLE}.release_note_type = 'NON_BREAKING_CHANGE';; label:"NON_BREAKING_CHANGE"}
      when:{sql:${TABLE}.release_note_type = 'SERVICE_ANNOUNCEMENT';; label:"SERVICE_ANNOUNCEMENT"}
      when:{sql:${TABLE}.release_note_type = 'placeholder';; label:"placeholder"}
      else: "OTHER"
    }
# FIX
# ISSUE
# FEATURE
# LIBRARIES
# DEPRECATION
# BREAKING_CHANGE
# SECURITY_BULLETIN
# NON_BREAKING_CHANGE
# SERVICE_ANNOUNCEMENT
    sql: ${TABLE}.release_note_type ;;
  }

  dimension: product_and_note_type {
    sql: concat(${product_name},'-',${TABLE}.release_note_type) ;;
  }

  dimension: kev_categorization {
    type: number
    sql:
    case when ${release_note_type} in ('BREAKING_CHANGE','DEPRECATION','SECURITY_BULLETIN') then 1
      else case when ${release_note_type} in ('FIX','FEATURE','ISSUE') then 2
        else 3
      end
    end  ;;
  }
  measure: max_kev_categorization {
    label: "Severity Type"
    type: max
    sql: ${kev_categorization} ;;
  }

  dimension: hidden_id {
    type: string
  }

  dimension_group: published_at {
    type: time
    timeframes: [raw,date,month]
    datatype: date
    sql: ${TABLE}.published_at ;;
  }
  dimension: published_date_end {
    type: date
    sql: DATE_ADD(${published_at_raw},INTERVAL 1 DAY) ;;
  }

  measure: min_date_measure {
    type: date
    sql: min(${published_at_date}) ;;
  }
  measure: min_date_end_measure {
    type: date
    sql: min(${published_date_end}) ;;
  }

  measure: count {
    type: count_distinct
    sql: concat(${published_at_date},${description}) ;;
    drill_fields: [product_name,release_note_type,description,published_at_date,count]
  }

### Specially formatted fields support {
  measure: descriptions_list {
    type: string
    sql: STRING_AGG(DISTINCT ${description}, '|RECORD|') ;;
  }

### }# END Specially formatted fields support }
  measure: count_click_for_details_and_drill {
    type: count_distinct
    sql: concat(${published_at_date},${description}) ;;
    # html:
    # {% assign text = descriptions_list._rendered_value %}
    # {% assign descriptions_array = text | split: "|RECORD|"%}
    # {% for a_description in descriptions_array %}
    #   <br> ⏺ {{a_description}}
    # {%endfor%};;
    link: {
      label: "{{count._rendered_value}} Notes... Click to see details... {% assign text = descriptions_list._rendered_value %}{% assign descriptions_array = text | split: \"|RECORD|\"%}{% for a_description in descriptions_array %}
      << {{a_description}} >> {%endfor%}"
      url: "{{count._link}}"
    }
    # drill_fields: []
  }




}
