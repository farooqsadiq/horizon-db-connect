#!/usr/bin/env ruby
#require 'pry'
require 'dotenv/load'
require 'tiny_tds'
require 'config'
require 'awesome_print'
require_relative 'queries'

config =  Config.load_and_set_settings("config/settings.yml")
client = TinyTds::Client.new config.horizon_db.to_hash

# books which are out to borrow direct. I do not think this is what I want
#sql = <<END_SQL.gsub(/\s+/, " ").strip
sql = "#$borrodir_sql" # "#$callnum_sql"
ap sql
results = client.execute( sql )
#binding.pry
results.each do |row|
  ap row
  # puts "#{row['callnum']}"
end
puts results.count
results.cancel

client.close
