# gem install data_mapper
# gem install dm-sqlite-adapter
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
