require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'

set :sessions, true

helpers do
	def calculate_total(cards) 
  # [['3', 'H'], ['Q', 'S'], ... ]
  localarray = cards.map{|e| e[0] }  
# Go through cards array and pull out the card values and put into 
# an array called localarray

# Change pictures in cards to a number
# For each element in the local array
# if the card is an ace, give it a value of eleven
# if not an ace, test for picture. Changing pic to integer results in
# a zero.  If not zero then card is not a picture, the number becomes 
# the value
#
  total = 0
  localarray.each do |value|
    if value == "A"
      total += 11
    elsif value.to_i == 0 # J, Q, K
      total += 10
    else
      total += value.to_i
    end
  end

  #correct for Aces
  # Function to adjust a person’s hand to remain below 21
  #  because an ace can be a one or eleven.
  # How: Subtract 10 from the hand for every ace the person
  #   has until the total value is below 21
  #
  localarray.select{|e| e == "A"}.count.times do
    total -= 10 if total > 21
  end

  total
end #end of def 
end #helpers block

get '/' do
 if session[:player_name]
 	 redirect '/game'
# go to games	once new player enters name
	elseif  #if no name, go get name of new player
		redirect '/new_player'
	end
end

get '/new_player' do
	erb :new_player
end

post '/new_player' do
	session[:player_name] = params[:player_name]
	#progress to games
	redirect '/game'

end

get '/game' do
	# create a deck and put it in session
	suits = ['H', 'D', 'S', 'C']
  cards = ['2', '3', '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A']
  session[:deck] = cards.product(suits).shuffle!

		session[:p_cards] = []
	  session[:dealercards] = []
	  session[:p_cards] << session[:deck].pop
	  session[:dealercards] << session[:deck].pop
	  session[:p_cards] << session[:deck].pop
	  session[:dealercards] << session[:deck].pop

	  dealertotal = calculate_total(session[:dealercards])
  	p_cardsum = calculate_total(session[:p_cards])



	  erb :game

end