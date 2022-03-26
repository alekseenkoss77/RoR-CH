module Reports
  class SoldProductsController < ApplicationController
    def index
      @items = SoldProductsReport.new.call(params[:from], params[:to])
    end
  end
end
