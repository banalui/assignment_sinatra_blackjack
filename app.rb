require "sinatra"
require "sinatra/reloader" if development?
require "erb"
require "bundler/setup"
require "./helpers/card_helper.rb"
require "./player.rb"
require "./deck.rb"

helpers CardHelper

enable :sessions

get '/' do	
  	erb :home
end

get '/blackjack' do
	deck = Deck.create_deck
	player_hand = []
	dealer_hand = []
	player_hand << Deck.deal_one_card!(deck)
	dealer_hand << Deck.deal_one_card!(deck)
	player_hand << Deck.deal_one_card!(deck)
	dealer_hand << Deck.deal_one_card!(deck)
	player = Player.new(player_hand)
	dealer = Player.new(dealer_hand)
	player.play
	dealer.rest
	save_deck(deck)
	save_player_hand(player_hand)
	save_dealer_hand(dealer_hand)
	reached_21 = (player.points == 21)
	erb :blackjack, locals: { player: player, dealer: dealer, finished: false}
end

post '/blackjack/hit' do
	player_hand = load_player_hand
	dealer_hand = load_dealer_hand
	player = Player.new(player_hand)
	dealer = Player.new(dealer_hand)
	player.play
	dealer.rest
	deck = load_deck
	player.cards << Deck.deal_one_card!(deck)
	if player.points > 21
		redirect to("/blackjack/stay"), "Now dealer has to play"
	else
		erb :blackjack, locals: { player: player, dealer: dealer, finished: false}
	end
	
end

get '/blackjack/stay' do
	player_hand = load_player_hand
	dealer_hand = load_dealer_hand
	player = Player.new(player_hand)
	dealer = Player.new(dealer_hand)
	player.rest
	dealer.play
	deck = load_deck
	while dealer.points < 17
		dealer.cards << Deck.deal_one_card!(deck)
	end
	erb :blackjack, locals: { player: player, dealer: dealer, finished: true}
end
