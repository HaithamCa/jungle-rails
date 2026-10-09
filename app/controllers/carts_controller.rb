class CartsController < ApplicationController

  def show
  end

  def add_item
    product_id = params[:product_id].to_s
    product = Product.find(product_id)

    current_cart_qty = (cart[product_id] || 0)
    new_cart_qty = current_cart_qty + 1

    if product.quantity == 0
      redirect_back fallback_location: root_path, alert: "#{product.name} is sold out."
    elsif new_cart_qty > product.quantity
      redirect_back fallback_location: root_path, alert: "Sorry, only #{product.quantity} available."
    else
      modify_cart_delta(product_id, +1)
      redirect_back fallback_location: root_path
    end
  end

  def remove_item
    product_id = params[:product_id].to_s
    modify_cart_delta(product_id, -1)
    redirect_back fallback_location: root_path
  end

  private

  def modify_cart_delta(product_id, delta)
    cart[product_id] = (cart[product_id] || 0) + delta
    cart.delete(product_id) if cart[product_id] < 1
    update_cart cart
  end

end