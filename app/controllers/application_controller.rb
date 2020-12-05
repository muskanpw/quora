class ApplicationController < ActionController::Base
  #before_action :authenticate_user!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?
  
  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:name,:cont_no, :email, :password, image_attributes:[:image])}
      devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name,:cont_no ,:email, :password, :current_password, image_attributes:[:image])}
    end
end
