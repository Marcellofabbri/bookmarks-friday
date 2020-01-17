feature "update bookmark" do
    scenario "updating a bookmark" do
      Bookmark.create(url: 'http://www.makersacademy.com', title: 'MakersAcademy')
      visit('/bookmarks')
      
      fill_in('url', with: "http://www.generalassembly.com")
      fill_in('title', with: "GA")
      first('.bookmark').click_button 'Update'
  
      expect(current_path).to eq '/bookmarks'
      expect(page).not_to have_content('Makers Academy')
      expect(page).to have_content("GA")

    end
  end