class AppliedOff < ActiveRecord::Base
  
  HOURS_PER_DAY=24
  MINUTES_PER_HOUR=60
  SECONDS_PER_MINUTE=60
  
  belongs_to :available_off
  validates_presence_of :available_off_id
  validates_associated :available_off
  
  belongs_to :employee
  validates_presence_of :employee_id
  
#  belongs_to :leave_policy
#  validates_presence_of :leave_policy_id
  
  validates_presence_of :status
  validates_presence_of :from_date
  validates_presence_of :to_date
  
  validates_inclusion_of :status, :in => %w(pending rejected approved)
  
  validate :from_date_and_to_date_not_to_be_exactly_same
  
  attr_reader :no_of_days
  
  def from_date_and_to_date_not_to_be_exactly_same
    self.errors.add_to_base("From date and to date cannot be same") if self.from_date == self.to_date
  end
  
  def before_create
    #if self.employee.available_offs.find_by_leave_policy_id(self.available_off.leave_policy.id).no_of_days - 1 < 0
    if self.available_off.no_of_days < (get_days_in_number(self.from_date,self.to_date))
      self.errors.add_to_base("You don't have enough leaves left in your account")
      return false
    end
  end
  
  def after_create
    update_available_leaves(self)
  end
  
  def update_available_leaves(applied_off)
    applied_off.available_off.update_attributes(:no_of_days => calculate_no_of_days(applied_off))
  end
  
  def calculate_no_of_days(applied_off)
    applied_off.available_off.no_of_days - get_days_in_number(applied_off.from_date,applied_off.to_date)
  end
  
  def self.list_all_pending_leaves(employee)
    find_by_sql("SELECT * FROM employees e,applied_offs a WHERE a.status='pending' 
    AND a.employee_id=e.id AND e.manager_id=#{employee.id}")
  end
  
  def approve
    self.update_attributes(:status => 'approved')
  end
  
  def get_days_in_number(from_date,to_date)
    (to_date-from_date)/(HOURS_PER_DAY * MINUTES_PER_HOUR * SECONDS_PER_MINUTE)
  end
  
  def reject
    self.update_attributes(:status => 'rejected')
    number=get_days_in_number(self.from_date,self.to_date)
    self.available_off.restore_leaves(number)
  end
  
  def no_of_days
    get_days_in_number(self.from_date,self.to_date)
  end
end
