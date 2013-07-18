# spec/support/features/session_helpers.rb
module Features
  module SessionHelpers
    def sign_up_with(email, name, password)
      visit '/register'
      fill_in 'Email', with: email
      fill_in 'Name', with: name
      fill_in 'Password', with: password
      fill_in 'Password confirmation', with: password
      click_button 'Register'
    end

    def sign_in
      user = create(:user)
      visit '/login'
      fill_in 'Email', with: user.email
      fill_in 'Name', with: user.name
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end

    def submit_idea(brief, industry, path = '/ideas/new')
      sign_in
      visit path
      fill_in 'Brief', with: brief
      fill_in 'Industry', with: industry
      click_button 'Create Idea'
      # Insert information to test updates here
    end

    def update_idea()
      click_button 'Update Idea'
    end

    # This must be called from an idea page
    def submit_aspect(title, brief)
      click_link 'Add aspect'
      fill_in 'Title', with: title
      fill_in 'Brief', with: brief
      click_link 'Add aspect'
    end
    # This must be called from an aspect page
    def submit_solution(brief)
      fill_in 'Brief', with: brief
      click_button 'Add solution'
    end
  end
end
