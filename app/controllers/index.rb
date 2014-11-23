get '/' do
  redirect '/login' unless logged_in?
  @decks = Deck.all
  erb :index
end

get '/decks/new' do
  erb :'new_deck'
end

post '/decks/new' do
  if params["name"] == ""
    flash[:error] = "Decks must have a name"
    redirect '/decks/new'
  elsif params["num_questions"].to_i > 50 || params["num_questions"].to_i < 0
    #how to hand non-numeric answers?
    flash[:error] = "Decks must have between 1 and 50 cards"
    redirect '/decks/new'
  else
    @num_questions = params["num_questions"].to_i
    @name = params["name"]
    erb :'new_card'
  end
end

post '/decks/create' do

end

get '/decks/:id' do
  redirect '/login' unless logged_in?
  flash.clear
  @deck = Deck.find_by(id: params[:id])
  redirect '/' unless @deck
  @round = Round.create(deck: @deck, user: get_current_user)
  card_ids = @deck.generate_shuffled_deck.map {|card| card.id}
  session[:deck] = card_ids
  session[:round_id] = @round.id
  redirect "/card/#{session[:deck].pop}"
end

get '/round/:id' do
  redirect '/login' unless logged_in?
  @round = Round.find_by(id: params[:id])
  redirect '/' unless @round
  redirect '/' unless @round.user_id == current_user_id
  @stats = @round.get_statistics
  @missed = @round.get_missed_questions
  erb :'/round'
end
