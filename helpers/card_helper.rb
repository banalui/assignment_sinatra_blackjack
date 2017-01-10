module CardHelper
	def string_rank(rank)
		string_rank = rank.to_s
		case rank
		when 11
			string_rank = "Jack"
		when 12
			string_rank = "Queen"
		when 13
			string_rank = "King"
		when 1
			string_rank = "Ace"
		end
		string_rank
	end

	def create_deck
		suits = ["❤️", "♠️", "♦️", "♣️"]
		ranks = (1..13).to_a
		cards = ranks.product(suits)
		cards.shuffle
	end

	def save_deck(deck)
    	session[:deck] = deck
  	end

  	def save_player_hand(hand)
  		session[:player_hand] = hand
  	end

  	def save_dealer_hand(hand)
  		session[:dealer_hand] = hand
  	end

  	def load_player_hand
  		session[:player_hand]
  	end

  	def load_dealer_hand
  		session[:dealer_hand]
  	end

  	def load_deck
    	session[:deck]
  	end

  	def deal_one_card!(deck)
  		card = deck.pop
  	end

  	def calculate_points(cards)
  		points = 0
  		cards.each do |card|
  			case card[0]
  			when 11, 12, 13
  				points += 10
  			when 1
  				(points < 11) ? points += 11 : points += 1
  			else
  				points += card[0]
  			end
  		end
  		points
  	end

  	def find_winner(final_player_points, final_dealer_points)
  		final_result = ""
  		if final_player_points > 21
  			if final_dealer_points > 21
				final_result = "Both Player and Dealer Busted, Hand is a tie!"
  			else
				final_result = "Player Busted! Dealer Wins"
  			end
  		else
			if final_dealer_points > 21
				final_result = "Dealer Busted! Player Wins"
  			else
  				if final_dealer_points == final_player_points
					final_result = "Hand is a tie!"
				elsif final_dealer_points > final_player_points
					final_result = "Dealer Wins!!"
				else
					final_result = "Player Wins!!"
				end
  			end
  		end
  	end
end