require 'securerandom'

class Shift

  attr_reader :character_set, :key, :offset

  def initialize
    @character_set = character_set
    @key = key
    @offset = offset
  end

  def create_character_set
    @character_set = ("a".."z").to_a << " "
  end

  def generate_random_number
    #uses SecureRandom module and .random_number method to return
    # 5-digit random number between 00000 and 10**5,
    # padding first digits as needed with zeros via .rjust
    @key = SecureRandom.random_number(10**5).to_s.rjust(5, '0')
    @key
  end

  def slice_key(key)
    keys_for_hash = [:A, :B, :C, :D]
    sliced = Hash.new

    keys_for_hash.each do |symbol|
      #take a 2-character slice of key
      sliced[symbol] = key.slice!(0..1)
      #then put back the second character so it can be included as first
      # character for the next hash value
      key.prepend(sliced[symbol][1])
    end
    sliced
  end

  def square_date(date)
    square = date ** 2
    square.to_s
  end

  def date_last_four(date)
    square_date(date)[-4..-1].to_i
  end



end
