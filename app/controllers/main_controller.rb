class MainController < ApplicationController
  before_action :access_my_market, only: %i[ my_market purchase_history]
  before_action :access_by_seller, only: %i[ sale_history my_inventory top_seller]
  before_action :reset_search, only: %i[login profile main purchase_history sale_history my_inventory top_seller ]

  def login
    if is_login?
      redirect_to main_main_path
    end
  end

  def create
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
    if must_be_logged_in
      @a = User.where(id: session['userId']).first
    end
  end

  def update_profile
      user = User.where(email: params[:email]).first
      if user
        redirect_to new_profile_path(name: params[:name]), alert: 'This email is already used.'
      else
        user = User.where(id: session["userId"]).first
        if user
          user.update(email: params[:email], name: params[:name], user_type: params[:role].to_i, lock_version: params[:lock_version].to_i)
          session[:userEmail] = user.email
          session[:user_type] = user.user_type
          redirect_to main_profile_path, :flash => { :success => "Update your profile successfully." }
        else
          redirect_to new_profile_path, :flash => { :alert => "Cannot change your profile. Please try again." } 
        end
      end
  end

  def update_password
    user = User.where(id: session["userId"]).first
    if user
      user.update(password: params[:newPassword], lock_version: params[:lock_version].to_i)
      redirect_to main_profile_path, :flash => { :success => "Change password successfully." }
    else
      redirect_to new_password_path, :flash => { :alert => "Cannot change your password. Please try agian." } 
    end
  end

  def new_account
  end

  def search_top
    tps = Inventory.joins("inner join users on users.id = inventories.seller_id").select("users.name, seller_id, sum(price) as total_price").where("inventories.created_at >= ? and inventories.created_at <= ?", params[:start_date], params[:end_date]).group(:seller_id).order("total_price DESC").first
    tqs = Inventory.joins("inner join users on users.id = inventories.seller_id").select("users.name, seller_id, sum(qty) as total_qty").where("inventories.created_at >= ? and inventories.created_at <= ?", params[:start_date], params[:end_date]).group(:seller_id).order("total_qty DESC").first
    if tps && tqs
      redirect_to top_seller_path(tps: {:name => tps.name, :total_price => tps.total_price}, tqs: {:name => tqs.name, :total_qty => tqs.total_qty})
    else
      redirect_to top_seller_path
    end
  end

  def top_seller
    if must_be_logged_in
      if params[:tqs] && params[:tps]
        @permitted_tqs = params.require(:tqs).permit(:name, :total_qty)
        @permitted_tps = params.require(:tps).permit(:name, :total_price)
      end
    end
  end

  def create_user
    user = User.where(email: params[:email]).first
    if user
      redirect_to new_account_path(name: params[:name]), alert: 'This email is already used.'
    else
      User.create(email: params[:email], name: params[:name], password: params[:password], user_type: params[:role].to_i)
      redirect_to main_login_path, :flash => { :success => "Your account has been created." }
    end
  end

  def sign_out
    reset_session
    redirect_to main_login_path
  end 

  #-----------------------------------------------

  def my_market
    @market = Market.all
  end

  def calculate_market
    amount = params[:amount].to_i
    id = params[:id]
    market = Market.find(id)
    if amount > market.stock
      redirect_to main_my_market_path, alert: 'Amount more than stock.'
    else
      market.stock = market.stock - amount
      if market.stock == 0
        market.destroy
      end
      market.save
      buyer_id = session[:userId]
      user_inventory = Inventory.where(user_id:buyer_id, item_id:market.item_id, price:market.price)
      Inventory.create(user_id:buyer_id, seller_id:market.user_id, price:market.price ,qty:amount ,item_id:market.item_id)
      redirect_to main_my_market_path
    end
  end

  def search_category
    item_id = []
    all_item = []
    is_all = params[:select]
    if is_all == 'all'
      all_item = Item.all
      all_item.each do |item|
        item_id.append(item.id)
      end
    else
      search = params[:category]
      item = Item.all
      item.each do |each_item|
        if each_item.category.include? search
          item_id.append(each_item.id)
        end
      end
    end
    session[:all_item] = item_id
    redirect_to main_my_market_path
  end

  def purchase_history
    u_id = session[:userId]
    @inventory = Inventory.where(user_id:u_id)
  end

  def sale_history
    u_id = session[:userId]
    @sale_history = Inventory.where(seller_id:u_id)
  end

  def my_inventory
    u_id = session[:userId]
    @inventory = Market.where(user_id:u_id)
  end

  def delete_item
    u_id = session[:userId]
    market_id = params[:market_id]
    market = Market.find(market_id)
    market.destroy
    redirect_to main_my_inventory_path, :flash => { :success => "Delete Successfully." }
  end

  def edit_product
    @item_id = params[:item_id]
    @market_id = params[:market_id]
    @item = Item.find(@item_id)
    @market = Market.find(@market_id)
  end

  def edit
    market_id = params[:market_id]
    item_id = params[:item_id]
    market = Market.find(market_id)
    item = Item.find(item_id)
    if params[:name] != "" 
      item.name = params[:name]
    end
    if params[:quantity] != "" 
      market.stock = params[:quantity].to_i
    end
    if params[:price] != "" 
      market.price = params[:price].to_f
    end
    if params[:enable] == "true" 
      item.enable = 1
    elsif params[:enable] == "false"
      item.enable = 0
    end
    if params[:image] != nil
      item.image = params[:image]
    end
    market.save
    item.save
    redirect_to main_my_inventory_path, :flash => { :success => "Edit Successfully." }
  end

  def add_product
  end

  def add
    u_id = session[:userId]
    name = params[:name]
    category = params[:category]
    price = params[:price]
    qty = params[:quantity]
    img = params[:image]
    Item.create(name:name,category:category,enable:1,image:img)
    id = Item.last.id
    Market.create(user_id:u_id,item_id:id,price:price,stock:qty)
    redirect_to main_my_inventory_path, :flash => { :success => "Create Product Successfully." }
  end

  private
    def reset_search
      session[:all_item] = nil
    end

end
