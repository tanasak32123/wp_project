class ApplicationController < ActionController::Base
    rescue_from ActiveRecord::StaleObjectError, with: :update_account_error

    def not_found_method
        render file: Rails.public_path.join('404.html'), status: :not_found, layout: false
    end

    def update_account_error
        redirect_to main_profile_path, :flash => {:alert => "This account been updated a minute ago."}
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

        def not_seller?
            user_id = session[:userId]
            user = User.find(user_id)
            if user.user_type != 'seller'
                return true
            else
                return false
            end
        end

        def access_my_market
            if not_seller?
                return true
            else
                redirect_to main_login_path, alert: "Sorry, Only Buyer can access."
            end
        end

        def not_buyer?
            user_id = session[:userId]
            user = User.find(user_id)
            if user.user_type != 'buyer'
                return true
            else
                return false
            end
        end

        def access_by_seller
            if not_buyer?
                return true
            else
                redirect_to main_login_path, alert: "Sorry, Only Seller can access."
            end
        end
end
