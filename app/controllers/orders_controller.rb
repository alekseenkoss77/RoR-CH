class OrdersController < ApplicationController
  before_action :find_order!, only: :show

  def index
    @orders = Order.includes(:user).order(id: :desc)
    @orders = @orders.where(id: params[:id]) if params[:id].present?
    @orders = @orders.joins(:user).where(users: { email: params[:email] }) if params[:email].present?

  end

  def show
  end

  private
  def find_order!
    @order = Order.find_by!(number: params[:number])
  end
end
