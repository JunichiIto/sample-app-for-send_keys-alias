require 'rails_helper'

feature 'User management' do
  background do
    Selenium::WebDriver.for :phantomjs
  end
  scenario "adds a new user", js: true do
    admin = create(:admin)
    sign_in admin

    visit root_path
    expect{
      click_link 'Users'
      click_link 'New User'

      fill_in 'Email', with: 'newuser@example.com'
      # clear_flagが有効であることを確認するために予め別の値をセットしておく
      find('#password').fill_in 'Password', with: 'secret123'
      page.driver.browser.find_element(:id, "user_password").send_keys('secret123', clear_flag: true)
      find('#password_confirmation').fill_in 'Password confirmation',
        with: 'secret123'
      click_button 'Create User'
    }.to change(User, :count).by(1)
    expect(current_path).to eq users_path
    expect(page).to have_content 'New user created'
    within 'h1' do
      expect(page).to have_content 'Users'
    end
    expect(page).to have_content 'newuser@example.com'
  end
end
