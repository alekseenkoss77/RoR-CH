class OrdersController < ApplicationController
  before_action :find_order!, only: :show

  def index
    @orders = Order
      .includes(:user)
      .by_number(params[:number])
      .by_email(params[:email])
      .order(id: :desc)
  end

  def show
    @order_presenter = ::OrderPresenter.new(@order)
  end

  private

  def find_order!
    @order = Order.includes(order_items: :source).find_by!(number: params[:number])
  end
end
