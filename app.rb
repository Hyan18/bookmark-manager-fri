require 'sinatra/base'
require 'sinatra/flash'
require './lib/bookmark.rb'
require './database_connection_setup.rb'
require 'uri'

class BookmarkManager < Sinatra::Base

  enable :sessions, :method_override
  register Sinatra::Flash

  get '/' do
    redirect 'bookmarks'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb (:bookmarks)
  end

  post '/bookmarks' do
    flash[:notice] = "You must submit a valid URL" unless Bookmark.create(url: params[:url], title: params[:title])

    redirect '/bookmarks'
  end

  get '/bookmarks/new' do
    erb(:'bookmarks/new')
  end

  delete '/bookmarks/:id' do
    Bookmark.delete(id: params[:id])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/update' do
    @bookmark_id = params[:id]
    @bookmark = Bookmark.find(id: @bookmark_id)
    erb(:'bookmarks/update')
  end

  patch '/bookmarks/:id' do
    Bookmark.update(id: params[:id], url: params[:url], title: params[:title])
    redirect '/bookmarks'
  end

  get '/bookmarks/:id/comments/new' do
    @bookmark_id = params[:id]
    erb(:'comments/new')
  end

  post '/bookmarks/:id/comments' do
    connection = PG.connect(dbname: 'bookmark_manager_test')
    connection.exec("INSERT INTO comments (text, bookmark_id) VALUES('#{params[:comment]}', '#{params[:id]}');")
    redirect '/bookmarks'
  end

  run! if app_file == $0
end
