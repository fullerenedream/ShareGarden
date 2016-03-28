helpers do
  def current_user
    if session[:user_id]
      User.find(session[:user_id])
    end
  end
end

get '/' do
  @spaces = Space.all
  if params[:search]
    search_term = params[:search]
    @spaces = @spaces.where("unit_number LIKE ? OR street_address LIKE ? OR province LIKE ? OR postal_code LIKE ? OR city LIKE ? OR country LIKE ? OR description LIKE ?", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%", "%#{search_term}%")
  end 
  if params[:country]
    @spaces = @spaces.where("country LIKE ?", "%#{params[:country]}%") unless params[:country]==""
  end
  if params[:province]
    @spaces = @spaces.where("province LIKE ?", "%#{params[:province]}") unless params[:province]==""
  end
  if params[:city]
    @spaces = @spaces.where("city LIKE ?", "%#{params[:city]}%") unless params[:city]==""
  end
  if params[:area]
    @spaces = @spaces.where("square_meters >= ?", params[:area]) unless params[:area]==""
  end
  if params[:outdoor] || params[:indoor]
    is_outdoor = params[:outdoor] == 'true'
    is_both = true if params[:outdoor] == 'true' && params[:indoor] == 'true'
    unless is_both
      @spaces = @spaces.where(outdoors: is_outdoor) unless params[:radio]==""
    end
  end
  erb :index
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
    redirect '/success.html'
  else
    redirect '/error.html'
  end
end

post '/spaces/addfavorites/:id/:flag' do
  if params[:flag]=='0'
    @favspaces = current_user.favorites.where(space_id: params[:id])
    @favspaces.each do |space|
      space.destroy
    end
  else
    Favorite.create(user_id: current_user.id, space_id: params[:id])
  end
  content_type :json
  {}.to_json

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
