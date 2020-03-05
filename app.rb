require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'pony'
# require 'sqlite3'

# def is_barber_exists? db, name
#   db.execute('select * from Barbers where name =?' [name]).length > 0
# end
#
# def seet_db db, barbers
#   barbers.each do |barber|
#     if is_barber_exists? db, barber
#       db.execute 'insert into Barbers (name) values (?)', [barber]
#   end
# end

# def get_db
#   return SQLlite3::Database.new 'users.sqlite'
# db.results_as_hash = true
# return db
# end

# configure do
#   db = get_db 'barbershop.db'
#   db.execute 'CREATE TABLE IF NOT EXISTS
#     "Users" (
#       "Id" INTEGER PRIMARY KEY AUTOINCREMENT,
#       "username" TEXT,
#       "phone" TEXT,
#       "datestemp" TEXT,
#       "barber" TEXT,
#       "color" TEXT
#     )'

# db.execute 'CREATE TABLE IF NOT EXIST
#   "Barbers" (
#     "id" INTEGER PRIMARY KEY AUTOINCREMENT,
#     "name" TEXT
#     )'
seet_db db, ['Jessie Pincman', 'Walter White', 'Gus Fring', 'Mike Ehrmantraut']
# end

get '/about' do
  erb :about
end

get '/visit' do
  erb :visit
end

get '/contacts' do
  erb :contacts
end

get '/' do
  erb :home
end

get '/login/form' do
  erb :login_form
end

get '/logout' do
  session.delete(:identity)
  erb "<div class='alert alert-message'>Logged out</div>"
end

get 'public/info.txt' do
  erb "<a href='/public/info.txt'></a>"
end

post '/login/form' do
  @login = params[:login]
  @password = params[:password]

  if @login == "Gor" && @password == "123"

    return "<a href='public/info.txt'></a>"
  else
    @error = "Wrong login or password"
    return erb :login_form
  end
end

post '/visit' do

  @username = params[:username]
  @phone = params[:phone]
  @date_time = params[:date_time]
  @barber = params[:barber]
  @color = params[:color]

  visit_form_alerts = {
    :username => 'Input your name',
    :phone => 'Input your phone',
    :date_time => 'Input your visiting date and time'
  }

  # visit_form_alerts.each do |key, value|
  #
  #   if params[key] == ''
  #     @error = visit_form_alerts[key]
  #     return erb :visit
  #   end
  # end

  @error = visit_form_alerts.select {|key,_| params[key] == ""}.values.join(", ")

  if @errof != ""
    return erb :visit
  end

  # db = get_db
  # db.execute 'insert into
  #   Users
  #   (
  #   username,
  #   phone,
  #   datestamp,
  #   barber,
  #   color
  #   )
  #   values (?, ?, ?, ?, ?)', [@username, @phone, @date_time, @barber, @color]

  visiters = File.open 'public/info.txt', 'a'
  visiters.write "Date and time: #{@date_time} | Phone: #{@phone} | Username: #{@username} | Barber: #{@barber} | Color: #{@color}\n"
  visiters.close

  @message = "YOUR INFO IS SENDED:\n\nDate and time: #{@date_time} | Phone: #{@phone} | Username: #{@username} | Barber: #{@barber} | Color: #{@color}"
  erb :visit
end

post '/contacts' do
  @name = params[:name]
  @email = params[:email]
  @comment = params[:comment]

  if @email == ''
    @error = "Need to input email"
  end

  contacts = File.open 'public/info_2.txt', 'a'
  contacts.write "Name: #{@name.capitalize}, email: | #{@email} |\nComment body: #{@comment}\n\n"
  contacts.close

  # Pony.mail(
  #   :name => params[:name],
  #   :email => params[:email],
  #   :body => params[:comment],
  #   :to => 'a 7495500@gmail.com',
  #   :subject => params[:name] + " has contacted you",
  #   :body => params[:message],
  #   :port => '587',
  #   :via => :smtp,
  #   :via_options => {
  #     :addres => 'smtp.gmail.com',
  #     :port => '587',
  #     :enable_starttls_auto => true,
  #     :user_name => 'Gor',
  #     :password => 'Qazx1234',
  #     :authentication => :plain,
  #     :domain => 'localhost.localdomain'
  #   }
  # )

  @message = "YOUR INFO IS SENDED" if @mail != ''
  erb :contacts
end

get '/showusers' do
  # db = get_db
  #
  # @results = db.execute 'select * from Users order by id desc'


  erb :showusers
end
