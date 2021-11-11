require_relative './spec_helper'
require './lib/shift'

RSpec.describe Shift do

  before(:each) do
    @shift = Shift.new
    @example_key1 = '01234'
    @example_date1 = 111589
  end

  it 'exists' do
    expect(@shift).to be_instance_of(Shift)
  end

  it 'has attributes' do
    expect(@shift.create_character_set).to eq(["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", " "])
  end

  it '#generate_random_number' do
    allow(@shift.generate_random_number).to receive(:digits).and_return(@example_key1)
  end

  it '#slice_key' do
    expect(@shift.slice_key(@example_key1)).to eq({:A => 01, :B => 12, :C => 23, :D => 34})
  end

  it '#square_date' do
    expect(@shift.square_date(@example_date1)).to eq("12452104921")
  end

  it '#date_last_four' do
    @shift.date_last_four(@example_date1)
    expect(@shift.date_digits).to eq("4921")
  end

  it '#slice_date' do
    date_digits = "4921"
    expect(@shift.slice_date(date_digits)).to eq({:A => 4, :B => 9, :C => 2, :D => 1})
  end

  it '#generate_offsets' do
    expect(@shift.generate_offsets).to eq({:A => 5, :B => 21, :C => 25, :D => 35})
  end
end
