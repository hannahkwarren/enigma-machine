require 'date'
require './shift'
require './lib/enigma'

RSpec.describe Enigma do

  before(:each) do
    @enigma_1 = Enigma.new
    @key_1 = '02715'
    @shift_1 = Shift.new
    @enigma_1.accept_key(@key_1)
    @date_1 = '040895'
    @message_1 = "hello world!"
    @message_2 = "HEYYY! EVERYBODY"
    @message_3 = "Absolute $*&#!"
  end

  it "exists" do
    expect(@enigma_1).to be_instance_of(Enigma)
  end

  it "Encryptable#generate_key" do
    allow(SecureRandom).to receive(:random_number).with(10**5).and_return('02715'
    )
    @enigma_1.generate_key
    expect(@enigma_1.key).to eq('02715')
    expect(@enigma_1.key.class).to be(String)
    expect(@enigma_1.key.length).to eq(5)
  end

  it "Encryptable#last_four" do
    @enigma_1.date_last_four(@date_1)
    expect(@enigma_1.four_digits).to eq("1025")
  end

  it "Encryptable#offsets" do
    allow(SecureRandom).to receive(:random_number).with(10**5).and_return('02715'
    )
    @enigma_1.date_last_four(@date_1)
    @enigma_1.generate_offsets
    expect(@enigma_1.offsets).to eq({:A => 3, :B => 27, :C => 73, :D => 20})
  end

  it "Encryptable#downcase_message" do
    expect(@enigma_1.downcase_message(@message_1)).to eq("hello world!")
    expect(@enigma_1.downcase_message(@message_2)).to eq("heyyy! everybody")
    expect(@enigma_1.downcase_message(@message_3)).to eq("absolute $*&#!")
  end

  it "Encryptable#encrypt with key and date specified" do
    allow(SecureRandom).to receive(:random_number).with(10**5).and_return('02715'
    )
    expect(@enigma_1.encrypt(@message_1, @key_1, @date_1)).to eq({
      encryption: "keder ohulw!",
      key: "02715",
      date: "040895"
      })
  end

  it "Encryptable#encrypt with no key specified" do
    allow(SecureRandom).to receive(:random_number).with(10**5).and_return('02715'
    )
    expect(@enigma_1.encrypt(@message_1, @date_1)).to eq({
      encryption: "keder ohulw!",
      key: "02715",
      date: "040895"
      })
  end

  xit "Encryptable#encrypt with no date specified" do
    allow(SecureRandom).to receive(:random_number).with(10**5).and_return('02715'
    )
    @enigma_1.generate_key(@shift_1)
    @enigma_1.date_last_four(@shift_1, @date_1)
    @enigma_1.generate_offsets(@shift_1)
    @enigma_1.downcase_message(@message_1)
    expect(@enigma_1.encrypt(@message_1, @key_1, @date_1)).to eq({
      encryption: "keder ohulw!",
      key: "02715",
      date: "040895"
      })
  end

  xit "Encryptable#encrypt with no key or date specified" do
    allow(SecureRandom).to receive(:random_number).with(10**5).and_return('02715'
    )
    # @enigma_1.create_character_set(@shift_1)
    @enigma_1.generate_key(@shift_1)
    @enigma_1.date_last_four(@shift_1, @date_1)
    @enigma_1.generate_offsets(@shift_1)
    @enigma_1.downcase_message(@message_1)
    expect(@enigma_1.encrypt(@message_1, @key_1, @date_1)).to eq({
      encryption: "keder ohulw!",
      key: "02715",
      date: "040895"
      })
  end


end
