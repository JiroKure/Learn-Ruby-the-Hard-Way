require 'sinatra'

set :port, 8080
set :static, true
set :public_folder, "static"
set :views, "views"

## Get images and display
def load_pictures
  return Dir.glob("static/images/*.{jpg,jpeg}")
end

get '/' do
  return "Hello World"
end

get '/hello/' do
  erb :hello_form
end

post '/hello/' do
  greeting = params[:greeting] || "Hello There"
  sender = params[:sender] || "Nobody"
  recipient = params[:recipient] || "You"
  puts recipient

  erb :index, :locals => {'greeting' => greeting, 'sender' => sender, 'recipient' => recipient}
end

get '/upload/' do
  @pictures = load_pictures
  erb :upload_form
end

## Image Upload Page
post '/upload/' do
  # log what the file object looks like
  uploaded_file = params[:myfile]
  puts "The file object is #{uploaded_file}"
  # create a new file in public/images/filename 
  target = open('./static/images/' + uploaded_file[:filename], "w")
  # now we have to write the file to our empty file
  target.write(uploaded_file[:tempfile].read)
  target.close()
  
  @pictures = load_pictures
  erb :upload_form
end
