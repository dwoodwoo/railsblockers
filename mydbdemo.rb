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

require 'dm-core'
require 'dm-migrations'

DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/development.db")

class Song
  include DataMapper::Resource
    property :id, Serial
    property :title, String
    property :lyrics, Text
    property :length, Integer
end

DataMapper.finalize
