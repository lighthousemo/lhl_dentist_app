# Model class connected to the table patients
class Patient < ActiveRecord::Base
  # Associations
  has_many :appointments

  validates :first_name, presence: true, length: { minimum: 2, message: "blah"}
  validates :last_name, presence: true
  validate :patient_since_is_in_the_future


private
  def patient_since_is_in_the_future
    # self is the object
    if self.patient_since > Date.today
      errors.add(:patient_since, "is in the future")
    end
  end
end
