require_relative './shift'

module Encryptable

  def generate_key
    @key = shift.generate_random_number
  end

  def last_four
    @four_digits = shift.date_last_four
  end

  def offsets
    shift.generate_offsets(key, four_digits)
  end

  def message_check(message)






end
