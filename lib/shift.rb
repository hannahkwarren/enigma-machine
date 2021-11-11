require 'securerandom'

class Shift

  attr_reader :character_set, :key, :date_digits, :offset

  def initialize
    @character_set = character_set
    @key = key
    @date_digits = date_digits
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
    key_hash_keys = [:A, :B, :C, :D]
    sliced_key = Hash.new

    key_hash_keys.each do |symbol|
      #slice off and return the first 2 characters of key
      sliced_key[symbol] = key.slice!(0..1)
      #then put back the second character at the beginning of leftover
      #  chars, so it can be included as first character for the next slice
      key.prepend(sliced_key[symbol][1])
    end
    sliced_key.map {|k, v| [k, v.to_i]}.to_h
  end

  def square_date(date)
    square = date ** 2
    square.to_s
  end

  def date_last_four(date)
    @date_digits = square_date(date)[-4..-1]
  end

  def slice_date(date_digits)
    date_hash_keys = [:A, :B, :C, :D]
    sliced_date = Hash.new

    date_hash_keys.each do |symbol|
      sliced_date[symbol] = date_digits.slice!(0).to_i
    end
    sliced_date
  end

  def generate_offsets
    
  end
end
