class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service
  attr_accessor :word, :guesses, :wrong_guesses

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

  def initialize(new_word)
  	@word = new_word
  	@guesses = ''
  	@wrong_guesses = ''
  end

  def guess(letter)
  	# if letter is empty, nil or not a letter
  	if not letter =~ /[[:alpha:]]/
  		raise ArgumentError, "Input needs to be a letter"
  	end

  	# if letter is repeated
  	if self.guesses.include? letter or self.wrong_guesses.include? letter
  		return false
  	end

  	# if letter is in the word modify guesses
  	# but don't modify wrong_guesses
  	if self.word.include? letter
  		self.guesses += letter
  		return true
  	end
  	
  	# if letter is not in the word, modify 
  	# wrong_guesses but not guesses
  	if !self.word.include? letter
  		self.wrong_guesses += letter
  		return true
  	end
  end

  # displays the word 
  def word_with_guesses
  	display = ''
  	iterword = self.word.dup
  	iterword.split("").each do |letter|
  		if self.guesses.include? letter
  			display += letter
  		else
  			display += '-'
  		end
  	end
  	return display
  end

  #checks the game status 
  def check_win_or_lose
  	display = word_with_guesses 
  	if self.wrong_guesses.length >= 7
  		return :lose 
  	elsif display == self.word
  		return :win 
  	else
  		return :play
  	end
  end

  		

  			

end

