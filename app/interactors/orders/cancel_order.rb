module Orders
  class CancelOrder < BaseInteractor
    def call(order)
      yield validate(order)

      order.with_lock do
        yield refund_payments(order)
        yield return_items(order)
        order.update!(state: Order::CANCELED)
      end

      Success(order)
    end

    private

    def validate(order)
      if [Order::ARRIVED, Order::CANCELED].include?(order.state)
        Failure(code: :order_cancel_wrong_state)
      else
        Success(true)
      end
    end

    def return_items(order)
      OrderItem
        .lock("FOR UPDATE NOWAIT")
        .where(source_type: Product.name)
        .where(order_id: order.id)
        .update_all(
          state: OrderItem::RETURNED,
          updated_at: Time.zone.now,
        )
      Success(true)
    end

    def refund_payments(order)
      time = Time.zone.now
      Payment
        .lock("FOR UPDATE NOWAIT")
        .where(order_id: order.id)
        .update_all(
          state: Payment::REFUNDED,
          refunded_at: time,
          updated_at: time
        )
      Success(true)
    end
  end
end
