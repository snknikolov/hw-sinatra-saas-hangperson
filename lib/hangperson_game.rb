class HangpersonGame

  # add the necessary class methods, attributes, etc. here
  # to make the tests in spec/hangperson_game_spec.rb pass.

  # Get a word from remote "random word" service

  # def initialize()
  # end
  attr_accessor :word
  attr_accessor :guesses
  attr_accessor :wrong_guesses
  
  def initialize(word)
    @word = word
    @guesses = ""
    @wrong_guesses = ""
  end
  
  def guess(letter)
    raise ArgumentError if (letter =~ /\p{Alpha}/) == nil
    return false if letter.length != 1
    letter.downcase!
    if @word.include?(letter) && !@guesses.include?(letter)
      @guesses += letter
      return true
    elsif !@word.include?(letter) && !@wrong_guesses.include?(letter)
      @wrong_guesses += letter
      return true
    end
    false
  end
  
  def word_with_guesses
    displayed = ""
    @word.each_char do |c| 
      if @guesses.include?(c)
        displayed << c
      else
        displayed << "-"
      end
    end
    displayed
  end
  
  def check_win_or_lose
    return :play if @wrong_guesses.length < 7 && word_with_guesses != @word
    return :lose if @wrong_guesses.length >= 7
    :win
  end

  def self.get_random_word
    require 'uri'
    require 'net/http'
    uri = URI('http://watchout4snakes.com/wo4snakes/Random/RandomWord')
    Net::HTTP.post_form(uri ,{}).body
  end

end
