class RegistrationsController < ApplicationController
	layout 'home'

	def create
		begin
			if User.created?(user_params)
				flash[:notice] = I18n.t('messages.signup_success')
				redirect_to root_path 
			else
				flash[:alert] = I18n.t('messages.signup_failed')
				redirect_to registrations_path
			end
		rescue => e
			Error.report_errors("Exception::RegistrationsController.create -> #{e.class}, error_message: #{e.message}")
		end
	end

	private

	def user_params
		params.permit(:first_name, :last_name, :email, :password)
	end

end
