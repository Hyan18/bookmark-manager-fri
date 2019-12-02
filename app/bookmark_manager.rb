require 'sinatra/base'
require './lib/bookmarks.rb'

class BookmarkManager < Sinatra::Base


  get '/' do
    redirect 'bookmarks'
  end

  get '/bookmarks' do
    @bookmarks = Bookmarks.all
    erb (:bookmarks)
  end

  run! if app_file == $0
end