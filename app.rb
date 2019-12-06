require 'sinatra/base'
require './lib/bookmark.rb'
require './database_connection_setup.rb'

class BookmarkManager < Sinatra::Base

  enable :method_override

  get '/' do
    redirect 'bookmarks'
  end

  get '/bookmarks' do
    @bookmarks = Bookmark.all
    erb (:bookmarks)
  end

  post '/bookmarks' do
    Bookmark.create(url: params[:url], title: params[:title])
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

  run! if app_file == $0
end
