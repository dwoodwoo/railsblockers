# myapp.rb
# require 'rubygems'
require 'sinatra'

enable :sessions

puts 'hello, world!'

# ------------------------------------------------------------------------------------------------------
# Let's play with routes!

get '/' do
  'Hello world!'
end

get '/foo' do
  'foo world!'
end

get '/doo' do
  'doo mundo!'
end

get '/noo/:id' do
  'noo is :id'
end

get '/boo/:id' do
  'boo is #{:id}'
end


get '/zoo/:id' do
  "zoo is #{params[:id]}"
end
# ah, finally


# nothing magic here...you can call it anything...
get '/loo/:house' do
  "loo is #{params[:house]}"
end

# but it needs to match
get '/too/:starship' do
  "too is #{params[:house]}"
end

# why doesn't anybody ever mention name-value pairs?
get '/woo/:id' do
  "woo is #{params[:id]}, <br>
  house = #{params[:house]}, <br>
  starship = #{params[:starship]}, <br>
  params are: #{params.inspect}
  "
end
# try with:
# localhost:4567/poo/7
# localhost:4567/poo/7?something=whatever
# localhost:4567/poo/7?nothing=moresweetnothings
# localhost:4567/poo/7?something=whatever&nothing=moresweetnothings
# localhost:4567/poo/7?something=whatever&nothing=more sweet nothings






#-----------------------------------------------------------------------------------------------------
# more on params, this time with forms
post '/formtest/' do
        "Now I am in formtest.<br>
        params are: #{params.inspect}"
end


post '/formtest2/' do
        "Now I am in formtest2.<br>
        params are: #{params.inspect}<br>
        name: #{params[:name]}<br>
        rank: #{params[:rank]}<br>
        cereal type: #{params[:cereal]}<br>
        not in form: #{params[:rubbish]}"
end

post '/formtest3/' do
        song = params[:song]
        "Now I am in formtest3.<br>
        params are: #{params.inspect}<br>
        song: #{params[:song]}<br>
        just title: #{song[:title]}"
end

post '/formtest4/' do
        "Now I am in formtest4.<br>
        params are: #{params.inspect}<br>
        house: #{params[:house]}<br>
        starship: #{params[:starship]}<br>
        starship name: #{params[:starship][:name]}<br>
        starship captain: #{params[:starship][:captain]}<br>
        lovesdubstep: #{params[:lovesdubstep]}"
end










# ---------------------------------------------------------------------------
# MVC time
# time for more layers...let's add View

# inline view -- sinatra only...scroll to bottom
get '/down' do
  erb :down
end


# put it in a views directory, rails-style
get '/funky' do
  erb :funky
end


get '/chunky/:dancemove' do
  @dancemove = params[:dancemove]
  erb :chunky
end


get '/monkey/:dancemove' do
  dancemove = params[:dancemove]
  @amped_up_dancemove = dancemove * 5
  erb :monkey
end


get '/lunky/:dancemove' do  # In Rails, request comes in on a ROUTE...
  def ampitup(mymove)       # runs on some CONTROLLER CODE
    mymove.upcase * 7
  end
  dancemove = params[:dancemove]
  @amped_up_dancemove = ampitup(dancemove)
  erb :lunky                # then goes to an ERB file
end











# -----------------------------------------------------------------------------------------------------
# let's do a very small session demo
get '/persist/:something' do
  session[:something] = params[:something]
  "okay, #{session[:something]} is now stored in the session variable"
end
# call with localhost:4567/persist/kirk
# then look at localhost:4567/whatsinsession
# then close the browser and reopen localhost:4567/whatsinsession


get '/whatsinsession' do
  "session[:something] is #{session[:something]}<br>
  the whole session: #{session.inspect}"
end










__END__
@@down
<h2>getting down</h2>

@@chunky
<h2>getting chunky</h2>
dance <%= @dancemove %>

@@monkey
<h2>getting monkey</h2>
amped dancemove <%= @amped_up_dancemove %><br>
dancemove is <%= @dancemove %>

@@lunky
<h2>getting lunky</h2>
amped dancemove <%= @amped_up_dancemove %><br>
dancemove <%= @dancemove %>
