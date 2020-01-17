feature "delete bookmark" do
  scenario "deleting a bookmark" do
    Bookmark.create(url: 'http://www.makersacademy.com', title: 'MakersAcademy')
    visit('/bookmarks')
    
    expect(page).to have_content('MakersAcademy')
    
    first('.bookmark').click_button 'Delete'
    
    expect(current_path).to eq '/bookmarks'
    expect(page).not_to have_content('MakersAcademy')
  end
end

# setting up test data
# check that data is present
# delete
# check data isn't present