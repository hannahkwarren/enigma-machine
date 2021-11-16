require 'securerandom'
require_relative './encryptable'
require_relative './decryptable'

class Enigma
  include Encryptable
  include Decryptable

  attr_reader :key, :four_digits, :offsets, :character_set

  def initialize
    @key = key
    @four_digits = four_digits
    @character_set = ("a".."z").to_a << " "
  end

  def accept_key(given)
    @key = given
  end

  def generate_key
    # returns 5-digit random number between 00000 and 10**5,
    # padding first digits as needed with zeros via .rjust
    @key = SecureRandom.random_number(10**5).to_s.rjust(5, '0')
  end

  def use_today_date
    today = Date.today
    "#{today.month}#{today.mday}#{today.year.to_s[2,3]}"
  end

  def square_date(date)
    int = date.to_i
    square = int ** 2
    square.to_s
  end

  def date_last_four(date)
    @four_digits = square_date(date)[-4..-1]
  end

  def slice_key(key)
    sliceable = key.clone

    key_hash_keys = [:A, :B, :C, :D]
    sliced_key = Hash.new

    key_hash_keys.each do |symbol|
      #slice off and return the first 2 characters of key
      sliced_key[symbol] = sliceable.slice!(0..1)
      #then put back the second character at the beginning of leftover
      #  chars, so it can be included as first character for the next slice
      sliceable.prepend(sliced_key[symbol][1])
    end
    sliced_key.map {|k, v| [k, v.to_i]}.to_h
  end

  def slice_date
    sliceable = @four_digits.clone
    date_hash_keys = [:A, :B, :C, :D]
    sliced_date = Hash.new

    date_hash_keys.each do |symbol|
      sliced_date[symbol] = sliceable.slice!(0)
    end
    sliced_date.map {|k, v| [k, v.to_i]}.to_h
  end

  def generate_offsets(key, four_digits)
    @offsets = slice_key(key).merge!(slice_date){ |key, key_slice, date_slice| key_slice + date_slice}
  end

  def downcase_message(message)
    message.downcase
  end

  def encrypt(message, provided_key = nil, provided_date = nil)

    if provided_key.class == String && provided_key.length == 6
      provided_date = provided_key
      provided_key = nil
      self.generate_key
    else
      self.accept_key(provided_key)
    end

    message = downcase_message(message)

    if provided_key == nil
      self.generate_key
    end

    if provided_date == nil
      provided_date = self.use_today_date
    end

    self.date_last_four(provided_date)
    self.generate_offsets(key, four_digits)

    text = _encrypt(@offsets, message, key)
    encrypted_text = {encryption: text, key: key, date: provided_date}
  end

  def decrypt(cyphertext, provided_key, provided_date = nil)

    if provided_date == nil
      provided_date = self.use_today_date
    end

    self.date_last_four(provided_date)
    self.accept_key(provided_key)
    self.generate_offsets(key, @four_digits)

    text = _decrypt(@offsets, cyphertext, key)
    decrypted_text = {decryption: text, key: key, date: provided_date}
  end

  def crack(cyphertext, provided_date = nil)

    (0..99999).each do |int|
      possible_key = int.to_s.rjust(5, '0')
      decrypted_text = self.decrypt(cyphertext, possible_key, provided_date)
      if decrypted_text[:decryption][-4..-1] == " end"
        return decrypted_text
      end
    end
  end

end
