require 'rails_helper'

RSpec.feature "User signup with password validation", type: :feature, js: true do
  scenario "Shows live feedback when passwords don't match" do
    visit '/signup'
    
    fill_in 'Name', with: 'Test User'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password123'
    
    # Before typing confirmation, no feedback
    expect(page).not_to have_css('#password-match-feedback.text-danger')
    expect(page).not_to have_css('#password-match-feedback.text-success')
    
    # Type mismatched confirmation
    fill_in 'Confirm Password', with: 'different'
    
    # Should show error message
    expect(page).to have_css('#password-match-feedback.text-danger')
    expect(page).to have_text('Passwords do not match')
    
    # Submit button should be disabled
    expect(find('#signup-submit')[:disabled]).to eq('true')
  end
  
  scenario "Enables submit when passwords match and meet minimum length" do
    visit '/signup'
    
    fill_in 'Name', with: 'Test User'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Confirm Password', with: 'password123'
    
    # Should show success message
    expect(page).to have_css('#password-match-feedback.text-success')
    expect(page).to have_text('Passwords match')
    
    # Submit button should be enabled
    expect(find('#signup-submit')[:disabled]).to be_nil
  end
  
  scenario "Shows error if password is too short" do
    visit '/signup'
    
    fill_in 'Name', with: 'Test User'
    fill_in 'Email', with: 'test@example.com'
    fill_in 'Password', with: 'test'
    fill_in 'Confirm Password', with: 'test'
    
    # Should show error about length
    expect(page).to have_css('#password-match-feedback.text-danger')
    expect(page).to have_text('at least 5 characters')
    
    # Submit button should be disabled
    expect(find('#signup-submit')[:disabled]).to eq('true')
  end
  
  scenario "Successfully creates account when validation passes" do
    visit '/signup'
    
    fill_in 'Name', with: 'New User'
    fill_in 'Email', with: 'newuser@example.com'
    fill_in 'Password', with: 'password123'
    fill_in 'Confirm Password', with: 'password123'
    
    click_button 'Create Account'
    
    # Should be redirected to home and signed in
    expect(page).to have_text('Signed in as New User')
    expect(current_path).to eq(root_path)
  end
end
