module Encryptable

  def _encrypt(offsets, message, key, date)

    offset_keys = offsets.keys

    offset_counter = 0

    encrypted_text = ""

    message.each_char do |character|

      if character_set.include?(character)
        location = character_set.index(character)
        # from list of symbols in offsets, get current offset - :A, :B, :C, or :D
        offset_index = offset_keys[offset_counter % offset_keys.length]
        # use offset_index to get the right number (value) in offsets
        current_offset = offsets[offset_index]

        offset_counter += 1

        new = character_set[(location + current_offset) % character_set.length]
        #add new char to new string

        encrypted_text += new
      else
        encrypted_text += "#{character}"
      end
    end
    encrypted_text
  end


end
