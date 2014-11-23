post '/cards/new' do
  p params
end

get '/card/:id' do
  # redirect '/login' unless logged_in?
  @card = Card.find_by(id: params[:id])
  redirect '/' unless @card
  erb :card
end

post '/cards/:id' do
  @card = Card.find_by(id: params[:id])
  result = @card.check(params[:answer])
  if result == true
    flash[:notice] = "Correct"
  else
    flash[:error] = "Incorrect. The correct answer is #{@card.answer}."
  end
  Round.find(session[:round_id]).guesses << Guess.create(card_id: params[:id],
                                                         is_correct?: result)
  next_card_id = session[:deck].pop
  redirect "/card/#{next_card_id}" if next_card_id
  redirect "/round/#{session[:round_id]}"
end
