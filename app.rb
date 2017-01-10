require "sinatra"
require "sinatra/reloader" if development?
require "erb"
require "bundler/setup"
require './helpers/card_helper.rb'

helpers CardHelper

enable :sessions

get '/' do	
  	erb :home
end

get '/blackjack' do
	deck = create_deck
	player_cards = []
	dealer_cards = []
	player_cards << deal_one_card!(deck)
	dealer_cards << deal_one_card!(deck)
	player_cards << deal_one_card!(deck)
	dealer_cards << deal_one_card!(deck)
	save_deck(deck)
	save_player_hand(player_cards)
	save_dealer_hand(dealer_cards)
	reached_21 = (calculate_points(player_cards) == 21)
	erb :blackjack, locals: { player_cards: player_cards, dealer_cards: dealer_cards, dealer_play: false , reached_21: reached_21, finished: false}
end

post '/blackjack/hit' do
	player_hand = load_player_hand
	dealer_hand = load_dealer_hand
	deck = load_deck
	player_hand << deal_one_card!(deck)
	player_points = calculate_points(player_hand)
	reached_21 = (calculate_points(player_hand) == 21)
	if player_points > 21
		redirect to("/blackjack/stay"), "Now dealer has to play"
	else
		erb :blackjack, locals: { player_cards: player_hand, dealer_cards: dealer_hand, dealer_play: false, reached_21: reached_21, finished: false}
	end
	
end

get '/blackjack/stay' do
	player_hand = load_player_hand
	dealer_hand = load_dealer_hand
	deck = load_deck
	dealer_points = calculate_points(dealer_hand)
	reached_21 = (calculate_points(player_hand) == 21)
	while dealer_points < 17
		dealer_hand << deal_one_card!(deck)
		dealer_points = calculate_points(dealer_hand)
	end
	erb :blackjack, locals: { player_cards: player_hand, dealer_cards: dealer_hand, dealer_play: true, reached_21: reached_21, finished: true}
end
