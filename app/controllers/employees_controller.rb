class EmployeesController < ApplicationController
  # Be sure to include AuthenticationSystem in Application Controller instead
  include AuthenticatedSystem
  
  before_filter :login_required

  # render new.rhtml
  def new
    @employee = Employee.new
  end
 
  def create
    #logout_keeping_session!
    @employee = Employee.new(params[:employee])

    success = @employee && @employee.save

    if success && @employee.errors.empty?
      
      # Protects against session fixation attacks, causes request forgery
      # protection if visitor resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset session
      #self.current_employee = @employee # !! now logged in
      #redirect_back_or_default('/')
      flash[:notice] = "Thanks for signing up!  We're sending you an email with your activation code."
      redirect_to :controller => 'site', :action => 'site'
    else
      flash[:error]  = "We couldn't set up that account, sorry.  Please try again, or contact an admin (link is above)."
      render :action => 'new'
    end
  end

end
