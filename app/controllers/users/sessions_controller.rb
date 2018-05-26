# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  protect_from_forgery with: :null_session
  before_action :configure_sign_in_params, only: [:create]
  before_action :authenticate_user!
  include HandleError
  
  # POST /resource/sign_in
  def create
    begin
      set_error_flag = true
      login_params = params[:users]
      if login_params[:email].present? && login_params[:password].present?
        user = User.by_email(login_params[:email])
        if user.present?
          if user.valid_password?(login_params[:password])
            if sign_in(user)
              set_error_flag = false
              redirect_to dashboard_index_path
            else
              flash[:alert] = I18n.t('messages.signin_failed')
            end
          else
            flash[:alert] = I18n.t('messages.inorrect_password')
          end
        else
          flash[:alert] = I18n.t('messages.user_not_exists')
        end
      else
        flash[:alert] = I18n.t('messages.fill_the_data')
      end
    rescue => e
      Error.report_errors("Exception::Users::SessionsController.create -> #{e.class}, error_message: #{e.message}")
    end
    redirect_to root_path if set_error_flag
  end
  
  # DELETE /resource/sign_out
  def destroy
    if user_signed_in?
      sign_out current_user
    end
  end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_in_params
    devise_parameter_sanitizer.permit(:users){ |u| u.permit(:email, :password) }
  end
end
