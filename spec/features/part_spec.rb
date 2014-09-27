require 'spec_helper'

feature 'User visits the build page' do
  before(:each) do
    @user = FactoryGirl.create(:user, admin: true)
    sign_in @user
    @part = FactoryGirl.create(:part)
    @idea = @part.component.idea_build.idea
    visit "/ideas/#{@idea.id}/build"
  end

  scenario 'and finds a bootsy area to type in' do
    # Check for a class specific to bootsy
    click_link 'Idea Description'
    page.html =~ /wysihtml5-toolbar/
  end

  scenario 'and saves work once finished' do
    click_link 'Idea Description'
    fill_in 'part_value', :with => 'some text'
    click_button "Save part"
    @part.value == 'some_text'
  end

  scenario 'and click start on a part' do
    click_button "1"
    expect(page).to have_selector(:link_or_button, 'Finish')
    expect(page).to have_content('Started')
  end

  scenario 'and button vanishes when status is accepted' do
    click_button "1"
    click_button "1"
    click_button "1"
    click_button "1"

    expect(page).not_to have_selector(:link_or_button, 'Accept')
    expect(page).to have_content('Accepted')
  end
end