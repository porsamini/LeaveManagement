require "#{RAILS_ROOT}/lib/tasks/loadinitialdata.rb"
namespace :create do
  desc "Creates all the designations."
  task :designations => :environment do
    puts "Loading all designations"
    LoadInitialData.load_all_designations
  end
  
  desc "Creates essential employees, with two VicePresident instances and an \
        admin to create other new employees."
  task :employees => :environment do
    puts "Loading essential employees"
    LoadInitialData.load_essential_employees
  end
  
  desc "Creates the leave policies"
  task :leave_policies => :environment do
    puts "Loading leave policies"
    LoadInitialData.load_leave_policies
  end
  
  desc "Loads up leaves for each employee in the employee database"
  task :day_offs => :environment do
    puts "Loading all the available leaves for each employee."
    LoadInitialData.load_day_offs
  end
  
  desc "Creates data for all the tables, namely, 'designations','employees', \
        'leave_policies'."
  task :all => [:designations, :employees, :leave_policies, :day_offs]
  
end