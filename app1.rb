require 'sqlite3'

db = SQLite::Database.new 'users.sqlite'
db.results_as_hash = true


db.execute 'select * from Users' do |row|

  puts "#{row[1]} going to visit #{row[3]}"
  # print row[1] print row['username']
  # print "\t-\t"
  # puts row[3] puts row['datestamp']
  puts '======='
end
