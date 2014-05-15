require 'sinatra'

get '/' do 
	"hello, world!"
end

get '' do
end

get '/foo/:id' do
	"I am now at foo #{params[:id]}"
end
