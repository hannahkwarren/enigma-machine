require_relative './shift'
require_relative './encryptable'
# require_relative './decryptable'

class Enigma
  include Encryptable
  # include Decryptable

  attr_reader :key, :four_digits, :offsets

  def initialize
    @current_shift = Shift.new
    @key = key
    @four_digits = four_digits
  end


end
