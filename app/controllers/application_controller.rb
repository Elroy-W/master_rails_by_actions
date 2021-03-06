# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  before_action :set_browser_uuid

  protected

  def fetch_home_data
    @categories = Category.grouped_data
    @shopping_cart_count = ShoppingCart.by_user_uuid(session[:user_uuid]).count
  end

  def set_browser_uuid
    uuid = cookies[:user_uuid]

    uuid ||= if logged_in?
               current_user.uuid
             else
               RandomCode.generate_utoken
             end

    update_browser_uuid uuid
  end

  def update_browser_uuid(uuid)
    session[:user_uuid] = cookies.permanent['user_uuid'] = uuid
    end
end
