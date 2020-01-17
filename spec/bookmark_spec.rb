require './lib/bookmark.rb'

describe Bookmark do


  describe '.all' do
    it 'returns a list of all the bookmarks' do
      connection = PG.connect(dbname: 'bookmark_manager_test')

      bookmark = Bookmark.create(url: "http://www.makersacademy.com", title: "MakersAcademy")
      Bookmark.create(url: "http://www.destroyallsoftware.com", title: "Destroy All Software")
      Bookmark.create(url: "http://www.google.com", title: "Google")

      bookmarks = Bookmark.all

      expect(bookmarks.first).to be_a Bookmark
      expect(bookmarks.first.id).to eq bookmark.id
      expect(bookmarks.first.url).to eq 'http://www.makersacademy.com'
      expect(bookmarks.first.title).to eq 'MakersAcademy'
    end
  end

  describe '.create' do
    it 'creates a new bookmark' do
      bookmark = Bookmark.create(url: 'http://www.yaytesting.com', title: 'YayTesting')
      persisted_data = PG.connect(dbname: 'bookmark_manager_test').query("SELECT * FROM bookmarks WHERE id = #{bookmark.id};")
      expect(bookmark.url).to eq 'http://www.yaytesting.com'
      expect(bookmark.title).to eq 'YayTesting'

      expect(bookmark).to be_a Bookmark
      expect(bookmark.id).to eq persisted_data.first['id']
      expect(bookmark.title).to eq 'YayTesting'
      expect(bookmark.url).to eq 'http://www.yaytesting.com'
    end
  end

  describe '.delete' do
    it "deletes a bookmark" do
      bookmark = Bookmark.create(title: 'YayTesting', url: :'http://www.yaytesting.com')

      Bookmark.delete(id: bookmark.id)

      expect(Bookmark.all.length).to eq 0
    end
  end

  describe '.update' do
    it "updates a bookmark" do
      bookmark = Bookmark.create(title: 'YayTesting', url: :'http://www.yaytesting.com')
      updated_bookmark = Bookmark.update(id: bookmark.id, title: 'UpdatedTesting', url: 'http://www.updatedtesting.com' )

      expect(updated_bookmark.id).to eq bookmark.id
      expect(updated_bookmark.title).to eq 'UpdatedTesting'
      expect(updated_bookmark.url).to eq 'http://www.updatedtesting.com'
    end
  end

end
