class MainController < ApplicationController
  before_action :access_my_market, only: %i[ my_market purchase_history]
  before_action :access_by_seller, only: %i[ sale_history my_inventory top_seller]
  before_action :reset_search, only: %i[login profile main purchase_history sale_history my_inventory top_seller ]

  def login
    session[:userId] = 2
  end

  def profile
  end

  def main
    reset_session
  end

  def my_market
    pp session[:all_item]
    pp '###############'
    # ขาดใส่รูป
    @market = Market.all
  end

  def calculate_market

    amount = params[:amount].to_i
    id = params[:id]
    market = Market.find(id)
    if amount > market.stock
      redirect_to main_my_market_path, alert: 'amount more than stock'
    else
      market.stock = market.stock - amount
      if market.stock == 0
        market.destroy
      end
      market.save
      
      # add item in inventory
      buyer_id = session[:userId]
      user_inventory = Inventory.where(user_id:buyer_id, item_id:market.item_id, price:market.price)
      Inventory.create(user_id:buyer_id, seller_id:market.user_id, price:market.price ,qty:amount ,item_id:market.item_id)

      redirect_to main_my_market_path
    end
  end

  def search_category
    # pp params[:select]
    # pp '-----------------'
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
    # item_id = params[:item_id]
    market_id = params[:market_id]
    # item = Item.find(item_id)
    market = Market.find(market_id)
    market.destroy
    redirect_to main_my_inventory_path, notice: 'Delete Successfully'
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

    market.save
    item.save

    redirect_to main_my_inventory_path, notice: 'Edit Successfully'

  end

  def add_product
  end

  def add
    u_id = session[:userId]
    name = params[:name]
    category = params[:category]
    price = params[:price]
    qty = params[:quantity]
    Item.create(name:name,category:category,enable:1)
    id = Item.last.id
    Market.create(user_id:u_id,item_id:id,price:price,stock:qty)
    redirect_to main_my_inventory_path, notice: 'Create Product Successfully' 
  end


  def top_seller
  end


  private
  
    def reset_search
      session[:all_item] = nil
    end

end
