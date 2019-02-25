config =  Config.load_and_set_settings("config/settings.yml")
$borrodir_sql = <<END_SQL
  SELECT
    TOP 5
    -- *,
    SUBSTRING(CONVERT(VARCHAR,dateadd(day, last_status_update_date, "#{config.epoc}"), 140),1, 10) updated,
    ibarcode,
    bib#,
    (SELECT i.processed FROM isbn i WHERE i.bib# = item.bib#) 'isbn',
    (SELECT t.processed FROM title t WHERE t.bib# = item.bib#) 'title',
    call_reconstructed 'call#'
  FROM item
  WHERE
    collection = 'borrdir'
    AND item_status = 'i'
    AND last_status_update_date > datediff(dd,"#{config.epoc}", "28 jan 2018")
  AND last_status_update_date < datediff(dd,"#{config.epoc}", "30 jan 2018")
END_SQL

$callnum_sql = <<END_SQL
  SELECT
    TOP 1000
    -- *,
    call_reconstructed 'callnum'
  FROM item
  WHERE
    collection = 'borrdir'
    AND item_status = 'i'
END_SQL
