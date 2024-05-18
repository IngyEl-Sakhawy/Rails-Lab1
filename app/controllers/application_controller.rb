class ApplicationController < ActionController::Base
    before_action :authenticate_user!
    before_action :set_current_ability

    rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, alert: exception.message
    end

    private

    def set_current_ability
    @current_ability ||= Ability.new(current_user)
    end

    def after_sign_in_path_for(resource)
        
        stored_location_for(resource) || root_path
    end
    
    def after_sign_out_path_for(resource_or_scope)
        
        root_path
    end
end
