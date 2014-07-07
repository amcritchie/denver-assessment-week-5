require "sinatra"
require "rack-flash"
require "./lib/database"
require "./lib/contact_database"
require "./lib/user_database"

class ContactsApp < Sinatra::Base
  enable :sessions
  use Rack::Flash

  def initialize
    super
    @contact_database = ContactDatabase.new
    @user_database = UserDatabase.new
    @logged_in = false

    jeff = @user_database.insert(username: "Jeff", password: "jeff123")
    hunter = @user_database.insert(username: "Hunter", password: "puglyfe")

    @contact_database.insert(:name => "Spencer", :email => "spen@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Jeff D.", :email => "jd@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Mike", :email => "mike@example.com", user_id: jeff[:id])
    @contact_database.insert(:name => "Kirsten", :email => "kirsten@example.com", user_id: hunter[:id])
  end

  get "/" do
    erb :root
  end

  get "/login" do
    erb :login
  end

  post "/login" do
    @logged_in = true
    if @logged_in == true
      flash[:notice] = "Welcome, " + params[:username]
    end
    redirect '/'
  end

end
