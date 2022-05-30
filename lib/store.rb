class Store < ActiveRecord::Base
  has_many :employees
  validates :name, length: { minimum: 3, message: "Store name must be at least 3 characters long." }
  validates :annual_revenue, numericality: { only_integer: true }
  validate :store_must_carry_either_mens_or_wonems_apparel

  before_destroy :check_if_employees


  def store_must_carry_either_mens_or_wonems_apparel
   if mens_apparel == false and womens_apparel == false
     #errors.add(:mens_apparel, "Store must carry either men's or women's apparel")
     #errors.add(:womens_apparel, "Store must carry either men's or women's apparel")
     errors.add(:apparel,  "Store must carry either men's or women's apparel")
   end
  end

  private

  def check_if_employees
    num_employees = self.employees.size
    if num_employees > 0
       throw :abort
    end  
  end

end
