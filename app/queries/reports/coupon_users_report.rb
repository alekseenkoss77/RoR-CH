module Reports
  class CouponUsersReport
    attr_reader :coupon_id

    def call(coupon_id = nil)
      @coupon_id = coupon_id

      fetch_records
    end

    private

    def applied_coupon_order_ids
      orders = Order.joins(:order_items).where(order_items: { source_type: Coupon.name })
      orders = orders.where(order_items: { source_id: coupon_id }) if coupon_id.present?
      orders.pluck(:id)
    end

    def fetch_records
      Order
        .select("users.email, count(orders.id) as count, sum(order_items.price) as revenue")
        .joins(:user)
        .joins(:order_items)
        .where(orders: { id: applied_coupon_order_ids })
        .group("users.email")
    end
  end
end
