require_relative './shift'

module Encryptable

  # def create_character_set(current_shift)
  #   current_shift.create_character_set
  # end

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

  def encrypt(message, key = nil, date = nil)
    self.downcase_message(message)
    @current_shift.create_character_set

    
    #all the symbols in the offsets hash, or :A, :B, :C, :D
    offset_keys = @offsets.keys

    #counter for the current loop
    offset_counter = 0

    #create an empty string for encrypted message
    encrypted_text = ""

    #get the new character for each character in message
    @prepped_message.each_char do |character|
      # if character exists in valid character_set...
      if @current_shift.character_set.include?(character)
        # find the character index in the character_set
        loc = @current_shift.character_set.index(character)
        # from list of the symbols in offsets, get the current_offset to use
        offset_index = offset_keys[offset_counter % offset_keys.length]
        # use the current_offset to get the right number (value) in offsets
        current_offset = @offsets[offset_index]
        #increment the offset_counter
        offset_counter += 1
        #arithmetic for getting the new character
        new = @current_shift.character_set[(loc + current_offset) % @current_shift.character_set.length]
        #add new char to new string
        encrypted_text += new
      else
        encrypted_text += "#{character}"
      end
    end

    {encryption: encrypted_text,
      key: key,
      date: date}
  end


end
