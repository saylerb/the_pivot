class CartItemsController< ApplicationController
  def index
    @cart = set_cart
  end

  def create
    item = Item.find(params[:id])
    @cart.add_item(item.id)
    flash[:add_item] = "Successfully added " \
                       "#{view_context.link_to item.name, item_path(item)}" \
                       " to your cart!"

    session[:cart] = @cart.contents
    redirect_to :back
  end

  def update
    item = Item.find(params[:id])
    @cart.update_quantity(item.id, params[:quantity]) if params[:quantity]
    flash[:notice] = "#{item.name}'s quantity is now updated!"
    session[:cart] = @cart.contents
    redirect_to cart_path
  end

  def destroy
    item = Item.find(params[:id])
    @cart.remove_item(item.id)
    flash[:remove_item] = "Successfully removed " \
                          "#{view_context.link_to item.name, item_path(item)}" \
                          " from your cart."
    session[:cart] = @cart.contents
    redirect_to cart_path
  end
end
