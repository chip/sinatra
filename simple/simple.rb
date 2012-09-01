require 'rubygems'
require 'sinatra'
require 'dm-core'
require 'dm-timestamps'

DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/simple.db")

class Subscriber
  
  include DataMapper::Resource
  
  property :id,         Serial
  property :email,      String
  property :created_at, DateTime
  property :updated_at, DateTime
end

DataMapper.auto_upgrade!

before do
  headers "Content-Type" => "text/html; charset=utf-8"
end

get '/' do
  @title = "Subscribe to our service"
  haml :new
end

get '/list' do
  @subscribers = Subscriber.all
  haml :list
end

post '/email' do
  @title = "Thank you"
  @subscriber = Subscriber.new(params[:subscriber])
  if @subscriber.save
    @message = "#{@subscriber.email} is subscribed"
    haml :list
  else
    @message = "Please enter a valid email address"
    haml :new
  end
  render
end