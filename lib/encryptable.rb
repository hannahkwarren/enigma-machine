require_relative './shift'

module Encryptable

  def generate_key(current_shift)
    @key = current_shift.generate_random_number
  end

  def date_last_four(current_shift, date)
    @four_digits = current_shift.date_last_four(date)
  end

  def generate_offsets(current_shift)
    @offsets = current_shift.generate_offsets(key, four_digits)
  end

  def downcase_message(message)
    @prepped_message = message.downcase
  end

  
end
