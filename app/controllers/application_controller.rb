class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up).push(:payment)
  end
end
