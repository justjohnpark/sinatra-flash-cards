get '/login' do
  redirect '/' if logged_in?
  erb :'users/login'
end

post '/login' do
  puts session[:user_id] = User.authenticate(params["email"], params["password"])
  unless logged_in?
    flash[:error] = "Email or password incorrect"
    redirect '/login'
  else
    redirect '/'
  end
end

get '/register' do
  redirect '/' if logged_in?
  erb :'users/register'
end

post '/register' do
  if params[:user]["password"] != params["password2"]
    flash[:error] = "Passwords did not match"
    redirect '/register'
  end

  @user_or_error = User.register(params[:user])
  if @user_or_error.class == User
    session[:user_id] = @user_or_error.id
    flash[:notice] = "User successfully created"
    redirect '/'
  elsif @user_or_error.class == String
    flash[:error] = @user_or_error
    redirect '/register'
  end

end

get '/logout' do
  session[:user_id] = nil
  flash[:notice] = "Successfully logged out"
  redirect '/'
end

get '/users/profile' do
  redirect '/' unless logged_in?
  @user = get_current_user
  @name = "#{@user.first_name} #{@user.last_name}"
  @rounds = @user.rounds
  @user.delete_null_rounds
  erb :'users/profile'
end
