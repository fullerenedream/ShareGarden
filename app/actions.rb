helpers do
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end
end


# Homepage (Root path)
get '/' do
  erb :index
end

# CALLED THE DIRECTORY SPACES FOR NOW, CHANGE LATER WHEN WE COME UP WITH A NAME
# ALSO CALLED THE INNER DIRECTORY ID, CHANGE LATER WHEN WE COME UP WITH A NAME
# Spaces GET

# Spaces GET
get '/spaces' do
  if params[:search]
    search_term = params[:search]
    @spaces = Space.where("unit_number LIKE ? OR street_address LIKE ? OR province LIKE ? OR postal_code LIKE ? OR city LIKE ? OR country LIKE ? OR description LIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%")
  else
    @spaces = Space.all
  end
  erb :'spaces/index'
end

# Spaces New POST
post '/spaces' do
  @random_name = rand(1000000).to_s 
  @uploaded_file = params[:uploaded_picture]
  File.open('./public/uploads/' + @random_name +".jpg", "w") do |f|
    f.write(@uploaded_file[:tempfile].read)
  end
  @space = Space.new(
    user: current_user,
    unit_number: params[:unit_number],
    street_address: params[:street_address],
    province: params[:province],
    postal_code: params[:postal_code],
    city: params[:city],
    country: params[:country],
    square_meters: params[:square_meters].to_f,
    outdoors: params[:outdoors]=="true",
    description: params[:description],
    main_photo: '/uploads/' + @random_name
  )
  if @space.save
    redirect '/'
  else
    erb :'spaces/new'
  end
end

#GET NEW
get '/spaces/new' do
  erb :'spaces/new'
end

#GET FAVORITES
get '/spaces/favorites' do
  @user = current_user
  erb :'spaces/favorites'
end

#GET ID
get '/spaces/:id' do
  @space = Space.find params[:id]
  erb :'spaces/show'
end

#FAKE LOGIN BY USER ID
get '/users/:id/login' do
  session[:user_id] = params[:id]
  redirect '/'
end

#LOGOUT
get '/logout' do
  session[:user_id] = nil
  redirect '/'
end
