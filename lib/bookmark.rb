require 'pg'

class Bookmark
  attr_reader :bookmarks
  def initialize(bookmarks = [])
    @bookmarks = bookmarks
  end

  def self.all
    if ENV['ENVIROMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec('SELECT * FROM bookmarks')
    result.map { |bookmark| bookmark["url"]}.join(" ")
  end

end
