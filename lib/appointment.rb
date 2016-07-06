class Appointment < ActiveRecord::Base
  belongs_to :patient
  # Assumtions:
  # - patient_id column inside the appointments table
  # - there is a Patient class
end
