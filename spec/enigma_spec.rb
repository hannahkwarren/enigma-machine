require 'date'
require './lib/enigma'

RSpec.describe Enigma do

  before(:each) do
    @enigma_1 = Enigma.new
    @string_1 = "hello world"
    @key_1 = '02715'
    @date_1 = '040895'
  end

  it "exists" do
    expect(@enigma_1).to be_instance_of(Enigma)
  end

  it "Encryptable#key" do
    @enigma_1.generate_key
    expect(@enigma_1.key.class).to be(Integer)
    @enigma_1.last_four
    expect(@enigma_1.key.length).to be(5)
    @enigma_offsets
  end

  it "#encrypt" do
    expect(@enigma.encrypt(@string_1, @key_1, @date_1)).to eq({
      encryption: "keder ohulw",
      key: "02715",
      date: "040895"
      })
  end


end
