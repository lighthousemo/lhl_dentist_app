require 'pry' # in case you want to use binding.pry
require 'active_record'

# Output messages from Active Record to standard out
ActiveRecord::Base.logger = Logger.new(STDOUT)

puts 'Establishing connection to database ...'
ActiveRecord::Base.establish_connection(
  adapter: 'postgresql',  # tell activerecord to use a postgres database
  database: 'ar_exercises', # name of database
  username: 'monica',
  password: '',
  host: 'localhost',
  port: 5432,
  pool: 5,
  encoding: 'unicode',
  min_messages: 'error'
)
puts 'CONNECTED'

puts 'Setting up Database (recreating tables) ...'

ActiveRecord::Schema.define do
  drop_table :patients if ActiveRecord::Base.connection.table_exists?(:patients)
  # ask active record to create a table called patients
  create_table :patients do |t|
    t.column :first_name, :string
    t.column :last_name, :string
    t.column :patient_since, :date
    t.timestamps null: false
  end

end








