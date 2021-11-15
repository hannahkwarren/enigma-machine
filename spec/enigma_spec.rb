require_relative './spec_helper'
require 'date'
require './lib/enigma'

RSpec.describe Enigma do

  before(:each) do
    @enigma_1 = Enigma.new
    @key_1 = '02715'
    @enigma_1.accept_key(@key_1)
    @date_1 = '040895'
    @key_2 = '01234'
    @date_2 = '111589'
    @message_1 = "hello world!"
    @message_2 = "HEYYY! EVERYBODY"
    @message_3 = "Absolute $*&#!"

    @enigma_2 = Enigma.new
  end

  it "exists" do
    expect(@enigma_1).to be_instance_of(Enigma)
  end

  it 'has attributes' do
    expect(@enigma_1.character_set).to eq(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "])
    expect(@enigma_1.key).to eq("02715")
  end

  it 'accepts a provided key value' do
    @enigma_1.accept_key('01234')
  end

  it "#generate_key" do
    @enigma_1.generate_key
    expect(@enigma_1.key.class).to be(String)
    expect(@enigma_1.key.length).to eq(5)
  end

  it '#square_date' do
    expect(@enigma_1.square_date(@date_1)).to eq("1672401025")
    expect(@enigma_1.square_date(@date_2)).to eq("12452104921")
  end

  it '#date_last_four' do
    @enigma_1.date_last_four(@date_1)
    expect(@enigma_1.four_digits).to eq("1025")
    @enigma_1.date_last_four(@date_2)
    expect(@enigma_1.four_digits).to eq("4921")
  end

  it '#slice_key' do
    expect(@enigma_1.slice_key(@key_1)).to eq({:A => 2, :B => 27, :C => 71, :D => 15})
    expect(@enigma_1.slice_key(@key_2)).to eq({:A => 01, :B => 12, :C => 23, :D => 34})
  end

  it '#slice_date' do
    @enigma_1.date_last_four(@date_2)
    expect(@enigma_1.slice_date).to eq({:A => 4, :B => 9, :C => 2, :D => 1})
  end

  it "#generate_offsets" do
    allow(SecureRandom).to receive(:random_number).with(10**5).and_return('02715'
    )
    @enigma_1.date_last_four(@date_1)
    @enigma_1.generate_offsets(@key_1, "4921")
    expect(@enigma_1.offsets).to eq({:A => 3, :B => 27, :C => 73, :D => 20})
  end

  it "#downcase_message" do
    expect(@enigma_1.downcase_message(@message_1)).to eq("hello world!")
    expect(@enigma_1.downcase_message(@message_2)).to eq("heyyy! everybody")
    expect(@enigma_1.downcase_message(@message_3)).to eq("absolute $*&#!")
  end

  it "#encrypt with key and date specified" do
    allow(SecureRandom).to receive(:random_number).with(10**5).and_return('02715'
    )
    expect(@enigma_1.encrypt(@message_1, @key_1, @date_1)).to eq({
      encryption: "keder ohulw!",
      key: "02715",
      date: "040895"
      })
  end

  it "#encrypt with no key specified" do
    allow(SecureRandom).to receive(:random_number).with(10**5).and_return('02715'
    )
    expect(@enigma_1.encrypt(@message_1, @date_1)).to eq({
      encryption: "keder ohulw!",
      key: "02715",
      date: "040895"
      })
  end

  it 'use_today_date' do
    expect(@enigma_1.use_today_date.class).to be(String)
    expect(@enigma_1.use_today_date.length).to eq(6)
  end

  

  it "#encrypt with no date specified" do
    allow(Date).to receive(:today).and_return(Date.new(2021,11,15))
    expect(@enigma_1.encrypt(@message_1, @key_1)).to eq({
      encryption: "mifatdqdwpy!",
      key: "02715",
      date: "111521"
      })
  end

  it "#encrypt with no key or date specified" do
    allow(SecureRandom).to receive(:random_number).with(10**5).and_return('02715'
    )
    allow(Date).to receive(:today).and_return(Date.new(2021,11,15))
    expect(@enigma_1.encrypt(@message_1)).to eq({
      encryption: "mifatdqdwpy!",
      key: "02715",
      date: "111521"
      })
  end


  it "#decrypt given key and date" do
    expect(@enigma_2.decrypt("keder ohulw", "02715", "040895")).to eq({decryption: "hello world",
      key: "02715",
      date: "040895"})
  end

  it "#decrypt given only key" do
    allow(SecureRandom).to receive(:random_number).with(10**5).and_return('02715'
    )
    allow(Date).to receive(:today).and_return(Date.new(2021,11,15))

    expect(@enigma_1.encrypt(@message_1)).to eq({
      encryption: "mifatdqdwpy!",
      key: "02715",
      date: "111521"
      })

    expect(@enigma_2.decrypt("mifatdqdwpy!", "02715")).to eq({decryption: "hello world!",
      key: "02715",
      date: "111521"})
  end

  xit 'cracks the code given only date' do
    expect(@enigma_2.encrypt("hello world end", "08304", "291018")).to eq({encryption: "vjqtbeaweqihssi", key: "08304", date: "291018"})
    expect(@enigma_2.crack("vjqtbeaweqihssi", "291018")).to eq({decryption: "hello world end", date: "291018", key: "08304"})
  end

  xit 'cracks the code given no additional info' do
    allow(Date).to receive(:today).and_return(Date.new(2021,11,15))
    @enigma_2.encrypt("hello world end", "08304", "291018")
    expect(@enigma_2.crack("vjqtbeaweqihssi")).to eq({decryption: "hello world end"})
  end
end
