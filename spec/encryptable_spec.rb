require_relative './spec_helper'
require './lib/enigma'

RSpec.describe Encryptable do

  it 'Encryptable#_encrypt' do
    enigma_1 = Enigma.new
    enigma_1.accept_key("02715")
    enigma_1.date_last_four('040895')
    enigma_1.generate_offsets("02715", "1025")
    expect(enigma_1.offsets).to eq({:A => 3, :B => 27, :C => 73, :D => 20})
    expect(enigma_1._encrypt(enigma_1.offsets, "hello world", '02715')).to eq("keder ohulw")
  end
end
