require 'rails_helper'

RSpec.feature "Sold out badge and button behavior", type: :feature, js: true do
  before :each do
    @category = Category.create! name: 'Apparel'
    
    @in_stock = @category.products.create!(
      name: 'In Stock Hat',
      description: 'Available now',
      image: open_asset('apparel1.jpg'),
      quantity: 10,
      price: 64.99
    )
    
    @sold_out = @category.products.create!(
      name: 'Sold Out Shoes',
      description: 'No longer available',
      image: open_asset('apparel1.jpg'),
      quantity: 0,
      price: 124.99
    )
  end

  scenario "Shows sold out badge and disabled button for products with zero quantity" do
    visit root_path
    
    # In-stock product should have working Add button
    within("article", text: 'In Stock Hat') do
      expect(page).not_to have_text('SOLD OUT')
      expect(page).to have_button('Add', disabled: false)
    end
    
    # Sold-out product should have badge and disabled button
    within("article", text: 'Sold Out Shoes') do
      expect(page).to have_text('SOLD OUT')
      expect(page).to have_button('Sold Out', disabled: true)
    end
  end

  scenario "Disables the + button in cart when at maximum quantity" do
    visit root_path
    
    # Add all available stock
    within("article", text: 'In Stock Hat') do
      10.times { find('button.btn-primary').click }
    end
    
    visit cart_path
    
    within("tr", text: 'In Stock Hat') do
      expect(page).to have_text('10') # quantity
      # The + button should be disabled
      plus_button = all('button').find { |btn| btn.text == '+' }
      expect(plus_button[:disabled]).to eq('true')
    end
  end
end
