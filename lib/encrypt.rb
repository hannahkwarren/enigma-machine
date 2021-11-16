require './lib/enigma'
require 'json'

# CLI prompt: ruby ./lib/encrypt.rb message.txt encrypted.txt

#read from message.txt
msg = File.open(ARGV[0], "r")
message = msg.read.chomp
msg.close

#find the encrypted message
enigma = Enigma.new
encrypted = enigma.encrypt(message)
# clean = encrypted[:encryption].gsub(/[\\\"]/,"")
# encrypted[:encryption] = clean

#write encrypted message to encrypted.txt
output = File.open(ARGV[1], "w")
prep = JSON.generate(encrypted)
final_hash = JSON.parse(prep, {:symbolize_names => true})
output.write(final_hash)
output.close

p "Your secret's safe with me! Created 'encrypted.txt' with the key '#{encrypted[:key]}' and date '#{encrypted[:date]}'."
