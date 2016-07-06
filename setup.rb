require 'pry' # in case you want to use binding.pry
require 'active_record'
require_relative './lib/patient.rb'
require_relative './lib/appointment.rb'

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
  drop_table :appointments if ActiveRecord::Base.connection.table_exists?(:appointments)
  drop_table :dentists if ActiveRecord::Base.connection.table_exists?(:dentists)
  # ask active record to create a table called patients
  create_table :patients do |t|
    # id is included automatically
    t.column :first_name, :string
    t.column :last_name, :string
    t.column :patient_since, :date
    t.timestamps null: false
    # the line above does
    # t.column :created_at, :timestamp
    # t.column :updated_at, :timestamp
  end
  create_table :appointments do |t|
    t.column :patient_id, :integer
    t.column :dentist_id, :integer
    t.column :on_date, :timestamp
    t.timestamps null: false
  end


end

# ActiveRecord Naming Conventions
# 1. Table names must be pluralized, all lower case, allowed to use underscores
#    ex. patients  or patient_records
# 2. Class names must be singular, camel case, start with a capital letter
#    ex. Patient   or PatientRecord
#    - the name of the file
#    ex. patient.rb    or patient_record.rb
#


# Add data to the database
bob = Patient.create(first_name: "Bob", last_name: "Smith", patient_since: 1.month.ago)

jenny = Patient.new(first_name: "Jenny", patient_since: 1.year.ago)
jenny.last_name = "Smith"
jenny.save

Appointment.create(patient_id: bob.id, on_date: 5.days.from_now)

# To get bob's appointments
bob.appointments




# # Query Methods
#
# all_patients = Patient.all # lazy loading. won't actually do the select until we use all_patients
# all_patients.each do |patient|
#   puts patient.first_name
# end
#
# jenny = Patient.where(first_name: "Jenny", last_name: "Smith")
# smiths = Patient.where(last_name: "Smith")
#
# jenny = Patient.find(2)
#
# # Get first patient with last name smith
# first_smith = Patient.find_by(last_name: "Smith")
#
# # Chaining Query Methods
# jenny = Patient.where(first_name: "Jenny")
# jenny = jenny.where(last_name: "Smith")
# jenny = jenny.limit(1)
#
#
#

binding.pry

puts "hello"


