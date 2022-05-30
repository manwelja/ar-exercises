require 'securerandom'

class Employee < ActiveRecord::Base
  belongs_to :store
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :hourly_rate, numericality: { greater_than_or_equal_to: 40, less_than_or_equal_to: 200, message: 'Hourly rate must be between 40 and 200 inclusive.' }
  validates :store_id, presence: true

  after_create :auto_generate_password
   
  private 

  def auto_generate_password
    empl_no_pass = Employee.where(password: nil)
    empl_no_pass.each do |rec| 
      pass = SecureRandom.hex(4)  
      rec.update(password: pass)
    end
  end  
end