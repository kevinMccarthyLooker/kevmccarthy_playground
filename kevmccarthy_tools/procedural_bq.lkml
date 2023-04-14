# Using things like:
# Variables (see DECLARE and SET)
# UDFs
# EXECUTE_IMMEDIATE

## EXAMPLE EXPLORE 1
explore: procedural_bq {
  #variables need to be declared and set before query or any CTES, so must go in sql_preamle
  sql_preamble:
  DECLARE target_word STRING DEFAULT 'methinks';
  DECLARE corpus_count, word_count INT64;

    SET (corpus_count, word_count) = (
    SELECT AS STRUCT COUNT(DISTINCT corpus), SUM(word_count)
    FROM bigquery-public-data.samples.shakespeare
    WHERE LOWER(word) = target_word
    );
    ;;
}

## EXAMPLE VEIW 1
view: procedural_bq {
  derived_table: {
    sql:

    SELECT
      FORMAT('Found %d occurrences of "%s" across %d Shakespeare works',
             word_count, target_word, corpus_count) AS result
        ;;
  }
  dimension: result {
    type: string
    sql: ${TABLE}.result ;;
  }
}
