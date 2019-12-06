feature 'Adding bookmarks' do

  scenario 'After logging in I want to save some website as my bookmark' do
    visit('/bookmarks/new')
    fill_in 'url', with: 'http://www.youtube.com'
    fill_in 'title', with: 'Youtube'
    click_button 'submit'
    expect(page).to have_link("Youtube", href: 'http://www.youtube.com')
  end

  scenario 'The bookmark must be a valid URL' do
    visit('/bookmarks/new')
    fill_in 'url', with: 'invalid bookmark'
    click_button 'submit'

    expect(page).not_to have_content("invalid bookmark")
    expect(page).to have_content("You must submit a valid URL")
  end

end
