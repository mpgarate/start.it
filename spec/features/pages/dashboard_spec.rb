require 'rails_helper'

feature 'User visits dashboard page' do
  scenario 'after signing up' do
  	sign_up_with 'email@example.com', "Dr. Example", "User", 'lkn521%@5n'
    expect(page).to have_content "My Followed Ideas"
  end
  scenario 'and see recent activity' do
  	title = "Ant farm made out of ice"
  	brief = "This explains the idea title"
  	submit_idea title, brief
  	click_link 'Labthi.ng'
  	page.should have_content title
  end
end