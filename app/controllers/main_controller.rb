class MainController < ApplicationController

  def login
    if is_login?
      redirect_to main_main_path
    end
  end

  def create
    User.transaction do
      user = User.where(email: params[:email]).first
      if user && user.authenticate(params[:password])
        session[:logged_in] = true
        session[:userId] = user.id
        session[:userEmail] = user.email
        session[:user_type] = user.user_type
        redirect_to main_main_path
      else
        redirect_to main_login_path, alert: 'Wrong username or password.' and return 
      end
    end
  end

  def main
    if must_be_logged_in
      @user = User.where(id: session['userId']).first
    end
  end

  def profile
    if must_be_logged_in
      @a = User.where(id: session['userId']).first
    end
  end

  def new_profile
    if must_be_logged_in
      @a = User.where(id: session['userId']).first
    end
  end

  def new_password
    must_be_logged_in
  end

  def update_profile
    User.transaction do
      user = User.where(email: params[:email]).first
      if user
        redirect_to new_profile_path(name: params[:name]), alert: 'This email is already used.'
      else
        user = User.where(id: session["userId"]).first
        if user
          user.update(email: params[:email], name: params[:name], user_type: params[:role].to_i)
          session[:userEmail] = user.email
          session[:user_type] = user.user_type
          redirect_to main_profile_path, :flash => { :success => "Update your profile successfully." }
        else
          redirect_to new_profile_path, :flash => { :alert => "Cannot change your profile. Please try again." } 
        end
      end
    end
  end

  def update_password
    User.transaction do
      user = User.where(id: session["userId"]).first
      if user
        user.password = params[:newPassword]
        user.save
        redirect_to main_profile_path, :flash => { :success => "Change password successfully." }
      else
        redirect_to new_password_path, :flash => { :alert => "Cannot change your password. Please try agian." } 
      end
    end
  end

  def new_account
    @email = params[:email]
    @name = params[:name]
  end

  def create_user
    User.transaction do
      user = User.where(email: params[:email]).first
      if user
        redirect_to new_account_path(name: params[:name]), alert: 'This email is already used.'
      else
        User.create(email: params[:email], name: params[:name], password: params[:password], user_type: params[:role].to_i)
        redirect_to main_login_path, :flash => { :success => "Your account has been created." }
      end
    end
  end

  def sign_out
    reset_session
    redirect_to main_login_path
  end 

end
