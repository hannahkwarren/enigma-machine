require_relative './encryptable'
require_relative './decryptable'

class Enigma
  include Encryptable
  include Decryptable

  attr_reader :key, :four_digits

  def initialize

  end


end
