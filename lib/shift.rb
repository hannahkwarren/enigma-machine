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

  def accept_existing_key(key)
    @key = key
  end

  def generate_random_number
    #uses SecureRandom module and .random_number method to return
    # 5-digit random number between 00000 and 10**5,
    # padding first digits as needed with zeros via .rjust
    @key = SecureRandom.random_number(10**5).to_s.rjust(5, '0')
    @key
  end

  def slice_key(key)
    sliceable = key.clone
    key_hash_keys = [:A, :B, :C, :D]
    sliced_key = Hash.new
    key_hash_keys.each do |symbol|
      #slice off and return the first 2 characters of key
      # require "pry"; binding.pry
      sliced_key[symbol] = sliceable.slice!(0..1)
      #then put back the second character at the beginning of leftover
      #  chars, so it can be included as first character for the next slice
      sliceable.prepend(sliced_key[symbol][1])
    end
    sliced_key.map {|k, v| [k, v.to_i]}.to_h
  end

  def square_date(date)
    int = date.to_i
    square = int ** 2
    square.to_s
  end

  def date_last_four(date)
    @date_digits = square_date(date)[-4..-1]
  end

  def slice_date
    date_hash_keys = [:A, :B, :C, :D]
    sliced_date = Hash.new

    date_hash_keys.each do |symbol|
      sliced_date[symbol] = date_digits.slice!(0)
    end
    sliced_date.map {|k, v| [k, v.to_i]}.to_h
  end

  def generate_offsets(key, date_digits)
    new = slice_key(key).merge!(slice_date){ |key, key_slice, date_slice| key_slice + date_slice}
    new
  end
end
