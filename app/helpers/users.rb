helpers do

  def logged_in?
    !(session[:user_id].nil?)
  end

  def current_user_id
    session[:user_id]
  end

  def get_current_user
    User.find(current_user_id) if logged_in?
  end

end
