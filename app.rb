require 'sinatra/base'
require './lib/bookmark'
# require 'whatever i called the class'

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override
  
  get '/' do
    erb :index
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  patch '/bookmarks' do
    Bookmark.update(id: params[:update_id], title: params[:update_title], url: params[:update_url])
    redirect '/bookmarks'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb :bookmarks
  end

  post '/bookmarks/new' do
    Bookmark.create(url: params[:add], title: params[:title])
    # url = params['add']
    # connection = PG.connect(dbname: 'bookmark_manager_test')
    # connection.exec("INSERT INTO bookmarks (url) VALUES('#{url}')")
    redirect '/bookmarks'
  end

  run! if app_file == $0

end
