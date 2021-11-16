require './lib/enigma'
require 'json'

#CLI prompt: ruby ./lib/crack.rb encrypted.txt cracked.txt 240818

#read from encrypted.txt
encrypted_file = File.open(ARGV[0], "r")
encrypted_msg = encrypted_file.read
encrypted_hash = eval(encrypted_msg)
encrypted_file.close

#crack the encrypted message
enigma = Enigma.new

if ARGV[2] != nil
  current_date = ARGV[2].dup.to_s
else
  current_date = nil
end

cracked = enigma.crack(encrypted_hash[:encryption], current_date)

#write cracked message to cracked.txt
output = File.open(ARGV[1], "w")
prep = JSON.generate(cracked)
final_hash = JSON.parse(prep, {:symbolize_names => true})
output.write(final_hash)
output.close

puts "We've cracked it! Created 'cracked.txt' with the cracked key #{final_hash[:key]} and date #{final_hash[:date]}"
