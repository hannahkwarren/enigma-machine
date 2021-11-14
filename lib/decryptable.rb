module Decryptable

  def _decrypt(offsets, cyphertext, key, date)

    offset_keys = offsets.keys

    offset_counter = 0

    decrypted_text = ""

    cyphertext.each_char do |character|
      if character_set.include?(character)
        loc = character_set.index(character)
        # from offset_keys, get the current_offset to use
        offset_index = offset_keys[offset_counter % offset_keys.length]
        # use offset_index to get the right offset value in offsets
        current_offset = offsets[offset_index]
        
        offset_counter += 1

        new = character_set[(loc - current_offset) % character_set.length]
        #add new char to new string
        decrypted_text += new
      else
        decrypted_text += "#{character}"
      end
    end
    decrypted_text
  end




end
