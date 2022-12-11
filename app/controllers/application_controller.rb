class ApplicationController < ActionController::Base

    def not_found_method
        render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
    end

    private 
        def is_login?
            return session[:logged_in] == true
        end

        def must_be_logged_in
            if is_login?
                return true
            else
                redirect_to main_login_path, alert: 'You must login before accessing this page.' 
            end
        end
end
