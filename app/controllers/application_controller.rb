class ApplicationController < ActionController::Base

    private
        def not_seller?
            user_id = session[:userId]
            user = User.find(user_id)
            if user.user_type != 1
                return true
            else
                return false
            end
        end

        def access_my_market
            if not_seller?
                return true
            else
                redirect_to main_login_path, alert: "Sorry, Only Buyer can access"
            end
        end

        def not_buyer?
            user_id = session[:userId]
            user = User.find(user_id)
            if user.user_type != 2
                return true
            else
                return false
            end
        end

        def access_by_seller
            if not_buyer?
                return true
            else
                redirect_to main_login_path, alert: "Sorry, Only Seller can access"
            end
        end

end
