class OrdersController < ApplicationController
  before_action :find_order!, only: [:show, :cancel]

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

  def cancel
    result = Orders::CancelOrder.new.call(@order)
    if result.success?
      flash[:notice] = I18n.t('orders.cancel.success')
    else
      flash[:alert] = I18n.t('orders.cancel.failure')
    end
    redirect_to order_path(@order)
  end

  private

  def find_order!
    @order = Order.includes(order_items: :source).find_by!(number: params[:number])
  end
end
