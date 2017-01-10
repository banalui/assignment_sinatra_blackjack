class Player

	attr_reader :cards, :turn
	
	def play
		@turn = true
	end

	def rest
		@turn = false
	end

	def initialize(cards)
		@cards = cards
		@turn = false
	end

	def blackjacked
		points == 21
	end

	def first_card_points
		points = 0
		card = @cards[0]
		case card[0]
  		when 11, 12, 13
  			points += 10
  		when 1
  			(points < 11) ? points += 11 : points += 1
  		else
  			points += card[0]
  		end
  		points
	end

	def points
		points = 0
  		@cards.each do |card|
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
end