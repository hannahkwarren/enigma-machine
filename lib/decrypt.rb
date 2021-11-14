require './lib/enigma'
require 'json'
# CLI prompt: ruby ./lib/decrypt.rb encrypted.txt decrypted.txt 82648 240818

#read from encrypted.txt
encrypted_file = File.open(ARGV[0], "r")
encrypted_msg = encrypted_file.read
encrypted_hash = eval(encrypted_msg)
encrypted_file.close

#find the decrypted message
enigma = Enigma.new
current_key = ARGV[2].dup
current_date = ARGV[3].dup
decrypted = enigma.decrypt(encrypted_hash[:encryption], current_key, current_date)

#write encrypted message to encrypted.txt
output = File.open(ARGV[1], "w")
prep = JSON.generate(decrypted)
final_hash = JSON.parse(prep, {:symbolize_names => true})
output.write(final_hash)
output.close

p "Got it! Created 'decrypted.txt' with the key #{decrypted[:key]} and date #{decrypted[:date]}"
