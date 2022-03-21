module Reports
  class CouponUsersController < ApplicationController
    def index
      @items = CouponUsersReport.new.call(params[:coupon_id])      
    end
  end
end
