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

  def accept_key(key)
    @key = @current_shift.accept_existing_key(key)
  end

  def generate_key
    @key = @current_shift.generate_random_number
  end

  def date_last_four(date)
    @four_digits = @current_shift.date_last_four(date)
  end

  def generate_offsets
    @offsets = @current_shift.generate_offsets(key, four_digits)
  end

  def downcase_message(message)
    message.downcase
  end

  def encrypt(message, provided_key = nil, provided_date = nil)

    if provided_key.class == String && provided_key.length == 6
      provided_date = provided_key
      provided_key = nil
    end

    message = downcase_message(message)
    @current_shift.create_character_set

    if provided_key == nil
      self.generate_key
    else
      self.accept_key(provided_key)
    end

    if provided_date == nil
      provided_date = @current_shift.use_today_date
    end

    self.date_last_four(provided_date)
    self.generate_offsets

    text = _encrypt(@offsets, @current_shift, message, provided_key, provided_date)
    encrypted_text = {encryption: text,
      key: key,
      date: provided_date}
  end

end
