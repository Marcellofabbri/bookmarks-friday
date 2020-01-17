require 'pg'

class Bookmark
  attr_reader :bookmarks, :url, :title, :id
  def initialize(id:, title:, url:)
    @id = id
    @url = url
    @title = title
  end

  def self.all
    if ENV['ENVIROMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec('SELECT * FROM bookmarks')
    # a = ObjectSpace.each_object(self).to_a
    
    #bookmark_instance = a.map { |bookmark| self. }
    result.map { |bookmark| Bookmark.new(id: bookmark['id'], title: bookmark['title'], url: bookmark['url']) }
    
    #url = result.map { |bookmark| bookmark["url"]}.join(" ")
    

  end

  def self.create(url:, title:)
    if ENV['ENVIROMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end

    result = connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{url}', '#{title}') RETURNING id, url, title")
    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])
    # new_bookmark = self.new(url, title)
    # new_url = new_bookmark.url
    # new_title = new_bookmark.title
    # connection.exec("INSERT INTO bookmarks (url, title) VALUES('#{new_url}', '#{new_title}');")
    # @new_bookmark = new_bookmark
  end

  def self.delete(id:)
    if ENV['ENVIROMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
    
    result = connection.exec("DELETE FROM bookmarks where id = #{id}")
  end

  def self.update(id:, url:, title:)
    if ENV['ENVIROMENT'] == 'test'
      connection = PG.connect(dbname: 'bookmark_manager_test')
    else
      connection = PG.connect(dbname: 'bookmark_manager')
    end
   
    result = connection.exec("UPDATE bookmarks SET title = '#{title}', url = '#{url}' where id = #{id} RETURNING id, url, title;")

    Bookmark.new(id: result[0]['id'], title: result[0]['title'], url: result[0]['url'])

  end

  def self.instance
    @new_bookmark
  end
end
