require 'rails_helper'

RSpec.describe "Cart management", type: :request do
  before(:each) do
    @category = Category.create!(name: "Apparel")
    @product = @category.products.create!(
      name: "Hat",
      price: 25,
      quantity: 5
    )
  end

  def get_cart_qty(product_id)
    cart_cookie = response.cookies['cart']
    return 0 unless cart_cookie
    cart_data = JSON.parse(cart_cookie)
    cart_data[product_id.to_s] || 0
  end

  describe "adding items" do
    it "allows adding an item when inventory is available" do
      post add_item_cart_path, { product_id: @product.id }, { 'HTTP_REFERER' => root_path }
      expect(response).to redirect_to(root_path)
      expect(get_cart_qty(@product.id)).to eq(1)
    end

    it "prevents adding more items than available quantity" do
      # Manually build a cart with 5 items
      cart_json = { @product.id.to_s => 5 }.to_json
      
      # Try to add a 6th when cart already has 5
      post add_item_cart_path, { product_id: @product.id }, {
        'HTTP_REFERER' => root_path,
        'HTTP_COOKIE' => "cart=#{CGI.escape(cart_json)}"
      }
      
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to match(/only 5 available/i)
    end

    it "prevents adding a sold-out item" do
      @product.update_column(:quantity, 0)
      
      post add_item_cart_path, { product_id: @product.id }, { 'HTTP_REFERER' => root_path }
      expect(response).to redirect_to(root_path)
      expect(flash[:alert]).to match(/sold out/i)
      expect(get_cart_qty(@product.id)).to eq(0)
    end

    it "allows removing items even when product is now sold out" do
      # Add an item first
      post add_item_cart_path, { product_id: @product.id }, { 'HTTP_REFERER' => root_path }
      cart_cookie = response.headers['Set-Cookie']
      expect(get_cart_qty(@product.id)).to eq(1)
      
      # Product sells out
      @product.update_column(:quantity, 0)
      
      # Should still be able to remove it
      post remove_item_cart_path, { product_id: @product.id }, { 'HTTP_REFERER' => root_path, 'HTTP_COOKIE' => cart_cookie }
      expect(response).to redirect_to(root_path)
      expect(get_cart_qty(@product.id)).to eq(0)
    end
  end
end
