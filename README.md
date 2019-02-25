# Horizon DB Connect
uses the freetds driver to connect to horizon and do a simple query

## installation
    brew install freetds
    bundle install

## use
populate a .env file with the fields from the env-example  

queries.rb contain SQL queries that can be modified for your purposes  
main.rb controls the format of the output

run with:

    bundle exec ruby main.rb
