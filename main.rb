#!/usr/bin/env ruby
#require 'pry'
require 'dotenv/load'
require 'tiny_tds'
require 'config'
require 'awesome_print'

config =  Config.load_and_set_settings("config/settings.yml")
client = TinyTds::Client.new config.horizon_db.to_hash

# books which are out to borrow direct. I do not think this is what I want
#sql = <<END_SQL.gsub(/\s+/, " ").strip
sql = <<END_SQL
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
ap sql
results = client.execute( sql )
#binding.pry
results.each do |row| 
  ap row 
end 
results.cancel

client.close
