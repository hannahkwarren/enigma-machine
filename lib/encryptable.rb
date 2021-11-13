require_relative './shift'

module Encryptable

  def _encrypt(offsets, message, key, date)

    #all the symbols in the offsets hash, or :A, :B, :C, :D
    offset_keys = offsets.keys

    #counter for the current loop
    offset_counter = 0

    #create an empty string for encrypted message
    encrypted_text = ""

    #get the new character for each character in message
    message.each_char do |character|
      # if character exists in valid character_set...
      if character_set.include?(character)
        # find the character index in the character_set
        loc = character_set.index(character)
        # from list of the symbols in offsets, get the current_offset to use
        offset_index = offset_keys[offset_counter % offset_keys.length]
        # use the current_offset to get the right number (value) in offsets
        current_offset = offsets[offset_index]
        #increment the offset_counter
        offset_counter += 1
        #arithmetic for getting the new character
        new = character_set[(loc + current_offset) % character_set.length]
        #add new char to new string
        encrypted_text += new
      else
        encrypted_text += "#{character}"
      end
    end
    encrypted_text
  end


end
