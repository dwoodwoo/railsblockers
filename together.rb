# gem install data_mapper
# gem install dm-sqlite-adapter
#
# then in irb (or pry)
# require './mydbdemo.rb'
# Song.auto_migrate!
#
# song = Song.new, etc.
#
# to see database (in a new command line):
# sqlite3 development.db
# pragma table_info(songs)
#

require 'sinatra'

require 'dm-core'
require 'dm-migrations'

helpers do
  def h(text)
    Rack::Utils.escape_html(text)
  end
end

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Song
  include DataMapper::Resource
    property :id, Serial
    property :title, String
    property :lyrics, Text
    property :length, Integer
end

DataMapper.finalize


get '/zoo/:id' do
  song = Song.get(params[:id])
  "variable is #{params[:id]}<br>
  song.title is #{song.title}<br>
  song.lyrics is #{song.lyrics}<br>
  song.length is #{@song.length}
  "
end

get '/woo/:id' do
  @song = Song.get(params[:id])
  erb :show
end

__END__
@@show
<html>
variable is <%= params[:id] %><br>
  params: <%= params.inspect %><br>
  song: <%= h @song.inspect %><br>
  note: lyrics is a text field which is lazy-loaded.<br>
  song.title is <%= @song.title %><br>
  song.lyrics is <%= "#{@song.lyrics*7} so right" %><br>
  song.length is <%= @song.length %>
</html>

