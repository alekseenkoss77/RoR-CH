require 'rails_helper'

RSpec.describe Orders::CancelOrder do
  describe '#call' do
    subject { described_class.new }

    let(:user) { create(:user) }
    let(:address) { create(:address, user: user) }
    let(:product) { create(:product) }
    let(:order) { create(:order, address: address, user: user) }
    let!(:order_item) do
      create(:order_item, order: order, source: product)
    end
    let(:payment) { create(:payment, order: order, amount: order_item.price) }

    it 'cancel order, returns order items and refund payments' do
      expect { subject.call(order) }
        .to change { order.reload.state }.from('building').to('canceled')

      expect(order.order_items.where(state: OrderItem::SOLD).exists?).to be_falsey
      expect(order.order_items.where(state: OrderItem::RETURNED).ids).to match_array(order.order_item_ids)
      expect(order.payments.where(state: Payment::REFUNDED).ids).to match_array(order.payment_ids)
    end

    context 'when order is already canceled' do
      let(:order) { create(:order, :canceled, address: address, user: user) }

      it 'returns failure' do
        expect(subject.call(order)).to be_failure
      end
    end
  end
end
