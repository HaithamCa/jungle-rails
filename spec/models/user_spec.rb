require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attribute' do
    @user = User.new(first_name: "name", email: "email@email.com", password: "password", password_confirmation: "password")
    expext(@user).to be_valid
  end

  it 'is not valid without password matches with confirmation password' do
    @user = User.new(first_name: "name", email: "email@email.com", password: "password", password_confirmation: "pass_word")
  end
end
