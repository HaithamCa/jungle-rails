require 'rails_helper'

RSpec.describe "Admin access", type: :request do
  def create_user(email:, admin:)
    User.create!(
      name: "Test User",
      email: email,
      password: "password",
      password_confirmation: "password",
      admin: admin
    )
  end

  def log_in(user)
    post "/login", email: user.email, password: "password"
  end

  it "uses the storefront category model inside the admin namespace" do
    expect(Admin::Category).to eq(Category)
  end

  it "keeps new accounts from becoming admins through signup" do
    post "/users", user: {
      name: "Shopper",
      email: "shopper@example.com",
      password: "password",
      password_confirmation: "password",
      admin: true
    }

    user = User.find_by_email("shopper@example.com")
    expect(user).to be_present
    expect(user.admin).to eq(false)
  end

  it "sends guests to login and does not let them delete products" do
    category = Category.create!(name: "Apparel")
    product = category.products.create!(name: "Hat", price: 12, quantity: 4)

    get "/admin/products"
    expect(response).to redirect_to("/login")
    expect(flash[:alert]).to eq("Log in with an admin account to continue.")

    delete "/admin/products/#{product.id}"
    expect(response).to redirect_to("/login")
    expect(Product.exists?(product.id)).to eq(true)
  end

  it "sends signed-in shoppers away from the admin area" do
    shopper = create_user(email: "shopper@example.com", admin: false)
    log_in(shopper)

    get "/"
    expect(response.body).not_to include('href="/admin/products"')

    get "/admin/products"
    expect(response).to redirect_to("/")
    expect(flash[:alert]).to eq("You do not have access to the admin area.")
  end

  it "lets an admin open the dashboard, products, and categories" do
    admin = create_user(email: "admin@example.com", admin: true)
    log_in(admin)

    get "/"
    expect(response.body).to include('href="/admin/products"')

    get "/admin/products"
    expect(response).to have_http_status(:ok)

    get "/admin/categories"
    expect(response).to have_http_status(:ok)

    category = Category.create!(name: "Apparel")
    2.times do |n|
      category.products.create!(name: "Hat #{n}", price: 12, quantity: 4)
    end

    get "/admin"
    expect(response).to have_http_status(:ok)
    expect(response.body).to match(/<span class="badge">2<\/span>\s*Products/)
    expect(response.body).to match(/<span class="badge">1<\/span>\s*Categories/)
  end

  it "returns an admin to the page they asked for after login" do
    admin = create_user(email: "admin@example.com", admin: true)

    get "/admin/categories"
    expect(response).to redirect_to("/login")

    log_in(admin)
    expect(response).to redirect_to("/admin/categories")
  end
end
