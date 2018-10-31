class Admin::OrdersController < Admin::BaseController
  before_action :load_order, only: %i(show)

  def index
    @orders = Order.select_order
  end

  def new; end

  def show
    @order_details = @order.order_details.select_order_detail
  end

  def edit; end

  def statistic
    @order_details = OrderDetail.created_between params[:start_date],
      params[:end_date]
    get_total
  end

  private

  def load_order
    @order = Order.find_by id: params[:id]
    return if @order.present?
    flash[:danger] = t "not_order"
    redirect_to admin_orders_url
  end

  def get_total
    @quantity_total = 0
    @price_total = 0
    @order_details.each do |ord|
      @quantity_total += ord.quantity
      @price_total += ord.total_price
    end
  end
end
