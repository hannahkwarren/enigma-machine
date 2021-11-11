require_relative './spec_helper'
require './lib/shift'

RSpec.describe Shift do

  before(:each) do
    @shift = Shift.new
    @stub_key = '01234'
    @stub_date = 111589
  end

  it 'exists' do
    expect(@shift).to be_instance_of(Shift)
  end

  it 'has attributes' do
    expect(@shift.create_character_set).to eq(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "])
  end

  it '#generate_random_number' do
    allow(@shift.generate_random_number).to receive(:digits).and_return(@stub_key)
  end

  it '#slice_key' do
    expect(@shift.slice_key(@stub_key)).to eq({:A => "01", :B => "12", :C => "23", :D => "34"})
  end

  it '#square_date' do
    expect(@shift.square_date(@stub_date)).to eq("12452104921")
  end

  it '#date_last_four' do
    expect(@shift.date_last_four(@stub_date)).to eq(4921)
  end

  it '#generate_offsets' do
    expect(@shift.generate_offsets).to eq({:A => 5, :B => 21, :C => 25, :D => 35})
  end
end
