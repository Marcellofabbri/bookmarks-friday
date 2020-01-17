feature 'Display bookmarks through /bookmark route' do
  scenario 'visits bookmarks and recieves back all bookmarks' do
    connection = PG.connect(dbname: 'bookmark_manager_test')

    connection.exec("INSERT INTO bookmarks (url, title) VALUES ('http://www.makersacademy.com', 'MakersAcademy');")
    connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://www.destroyallsoftware.com', 'Destroy');")
    connection.exec("INSERT INTO bookmarks (url, title) VALUES('http://www.google.com', 'Google');")
    
    visit('/bookmarks')
    
    expect(Bookmark.all[0].title).to include "MakersAcademy"
    expect(Bookmark.all[1].title).to include "Destroy"
    expect(Bookmark.all[2].title).to include "Google"
  end
end
