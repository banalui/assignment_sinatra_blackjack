class Deck
	def self.create_deck
		suits = ["❤️", "♠️", "♦️", "♣️"]
		ranks = (1..13).to_a
		cards = ranks.product(suits)
		cards.shuffle
	end

	def self.deal_one_card!(deck)
  		card = deck.pop
  	end
end