class ApplicationController < ActionController::Base
	 skip_before_action :verify_authenticity_token
	 include HandleError, ApplicationHelper

	 def redirect_to_dashboard
	 	if user_signed_in?
	 		redirect_to dashboard_index_path
	 	end
	 end

end
