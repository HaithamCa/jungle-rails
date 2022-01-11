require 'rails_helper'

RSpec.describe User, type: :model do
  it 'is valid with valid attribute' do
    @user = User.new(first)
  end
end
