class BusinessesController < ApplicationController

  def index
    @businesses = Business.all
  end

  def show
    @business = Business.find_by(id: params[:id])
    @items = @business.items
  end
end