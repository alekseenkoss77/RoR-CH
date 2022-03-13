class OrderPresenter < SimpleDelegator
  def human_address
    "#{address.address1} #{address.address2}, #{address.city}, #{address.state}, #{address.zipcode}"
  end
end
