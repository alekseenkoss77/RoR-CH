module Reports
  class SoldProductsReport
    attr_reader :from, :to

    def call(from, to)
      @from = to_date(from)
      @to = to_date(to)
      fetch
    end

    private

    def fetch
      relation =
        Product
          .select("products.id, products.name, SUM(order_items.quantity) as number, SUM(order_items.price) AS revenue")
          .joins("INNER JOIN order_items ON order_items.source_id = products.id AND order_items.source_type = 'Product'")
          .where(order_items: { state: OrderItem::SOLD })
          .group("products.id")

      relation = relation.where("order_items.created_at >= ?", from) if from.present?
      relation = relation.where("order_items.created_at <= ?", to) if to.present?
      relation
    end

    def to_date(str)
      Date.parse(str)
    rescue ArgumentError
      nil
    end
  end
end
